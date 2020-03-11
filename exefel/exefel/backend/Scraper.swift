//
//  Scraper.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit
import WebKit

class Scraper: NSObject {
  struct Result {
    let games: [ResultGame]
    let created: Date
  }
  
  struct ResultGame {
    let underlying: Game
    let homeTeam: ResultGameTeam
    let awayTeam: ResultGameTeam
    let timeGameStarts: Date
    let televisionNetwork: String
    let weekNumber: Int
    
    init?(_ game: Game) {
      self.underlying = game
      
      guard let homeTeamName = game.homeTeamName,
            let homeTeamAbbr = game.homeTeamAbbr,
            let homeScore = game.homeScore else {
        return nil
      }
      
      self.homeTeam = ResultGameTeam(name: homeTeamName, abbreviation: homeTeamAbbr, score: homeScore)
      
      guard let awayTeamName = game.awayTeamName,
            let awayTeamAbbr = game.awayTeamAbbr,
            let awayScore = game.awayScore else {
        return nil
      }
      
      self.awayTeam = ResultGameTeam(name: awayTeamName, abbreviation: awayTeamAbbr, score: awayScore)
      
      
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      
      guard let gameStartTimestampUTC = game.gameStartTimestampUTC, let date = formatter.date(from: gameStartTimestampUTC) else {
        return nil
      }
      
      self.timeGameStarts = date
      
      let televisionNetwork = game.network ?? "??"
      self.televisionNetwork = televisionNetwork
      
      guard let weekNumber = game.weekNumber else {
        return nil
      }
      
      self.weekNumber = weekNumber
    }
  }
  
  struct ResultGameTeam {
    let name: String
    let abbreviation: String
    let score: Int
  }
  
  /*
  func get(_ completion: (Scraper.Result?) -> ()) {
    guard let url = URL(string: "https://betsapi.com/lt/22034/XFL") else {
      completion(nil)
      return
    }
    
    do {
      let htmlContents = try String(contentsOf: url)
      let result = buildResult(baseURL: url, htmlString: htmlContents)
      completion(result)
    } catch {
      completion(nil)
    }
  }*/
  
  fileprivate let XFL_SCRAPE_URL = "https://stats.xfl.com/Carousel"
  fileprivate var awaitingCompletion: ((Scraper.Result?) -> ())?
  fileprivate var hiddenWebView: WKWebView?
  
  // https://stackoverflow.com/questions/34751860/get-html-from-wkwebview-in-swift
  func get(_ completion: @escaping (Scraper.Result?) -> ()) {
    guard awaitingCompletion == nil else {
      completion(nil)
      return
    }
    
    guard let url = URL(string: XFL_SCRAPE_URL) else {
      completion(nil)
      return
    }
    
    let userContentController = WKUserContentController()
    let javascriptString = "webkit.messageHandlers.didGetHTML.postMessage(document.documentElement.outerHTML.toString());"
    let script = WKUserScript(source: javascriptString, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
    userContentController.addUserScript(script)
    userContentController.add(self, name: "didGetHTML")

    let prefs = WKPreferences()
    prefs.javaScriptEnabled = true // allows for the js variable "games" to become accessible
    
    let config = WKWebViewConfiguration()
    config.preferences = prefs
    config.userContentController = userContentController
    
    awaitingCompletion = completion
  
    hiddenWebView = WKWebView(frame: .zero, configuration: config)
    hiddenWebView?.load(URLRequest(url: url))
  }
}

extension Scraper: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let completion = awaitingCompletion else {
      return
    }
    
    guard message.name == "didGetHTML" else { //, let html = message.body as? String else {
      return
    }
    
    guard let webView = message.webView, let url = webView.url ?? URL(string: XFL_SCRAPE_URL) else {
      return
    }
    
    checkForTeamsThenComplete(webView, url: url, completion: completion)
  }
  
  func checkForTeamsThenComplete(_ webView: WKWebView, url: URL, attempts: Int=100, completion: @escaping ((Scraper.Result?) -> ())) {
    guard attempts > 0 else {
      return
    }
    
    webView.evaluateJavaScript("games", completionHandler: { (value, error) in
      guard let games = value as? [[String: Any]] else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          self.checkForTeamsThenComplete(webView, url: url, attempts: attempts-1, completion: completion)
        }
        return
      }
      
      // let decoded = Scraper.decode(html: string) let result = self.buildResult(games)
      let resultGames = games.compactMap {
        Scraper.ResultGame(Game(json: $0))
      }
      let result = Scraper.Result(games: resultGames, created: Date())
      completion(result)
    })
  }
}

//
//extension Scraper {
//  fileprivate func buildResult(baseURL url: URL, htmlString: String) -> Scraper.Result? {
//    let subredditLeaderboardPattern =  #"<a class="(.*?)" rel="noopener" target="_blank" href="\/r\/(.*?)\/">"#
//    let matches = matchStringPattern(baseURL: url, htmlString: htmlString, pattern: subredditLeaderboardPattern)
//    return nil
//  }
//
//  fileprivate func matchStringPattern(baseURL: URL, htmlString: String, pattern: String) -> [String] {
//    return htmlString.matches(for: pattern, group: 2)
//  }
//
//  fileprivate static func decode(html: String) -> String {
//    let htmlUTF8 = html.utf8
//    let htmlData = Data(htmlUTF8)
//    do {
//      let decoded = try NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//      return decoded.string
//    } catch {
//      // ErrorStore.shared.add(webViewItem: ErrorStoreItem(error: RedditNetworkerError("SubmarineHTMLStringTransformer decode() html \(html) caused exception: \(error.localizedDescription)"), date: Date(), sender: SubmarineHTMLStringTransformer.self))
//      return html
//    }
//  }
//}
