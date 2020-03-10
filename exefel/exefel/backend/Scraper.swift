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
    let homeTeam: ResultGameTeam
    let awayTeam: ResultGameTeam
    let timeGameStarts: Date
    let timeGameEnded: Date?
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

    let config = WKWebViewConfiguration()
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
    
    guard message.name == "didGetHTML", let html = message.body as? String else {
      return
    }
    
    guard let webView = message.webView, let url = webView.url ?? URL(string: XFL_SCRAPE_URL) else {
      return
    }
    
    checkForTeamsThenComplete(webView, url: url, completion: completion)
  }
  
  func checkForTeamsThenComplete(_ webView: WKWebView, url: URL, completion: @escaping ((Scraper.Result?) -> ())) {
    webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (value, error) in
      guard let string = value as? String else {
        return
      }
      
      guard string.contains("var games") else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          self.checkForTeamsThenComplete(webView, url: url, completion: completion)
        }
        return
      }
      
      let result = self.buildResult(baseURL: url, htmlString: string)
      completion(result)
    })
  }
}

extension Scraper {
  fileprivate func buildResult(baseURL url: URL, htmlString: String) -> Scraper.Result? {
    let subredditLeaderboardPattern =  #"<a class="(.*?)" rel="noopener" target="_blank" href="\/r\/(.*?)\/">"#
    let matches = matchStringPattern(baseURL: url, htmlString: htmlString, pattern: subredditLeaderboardPattern)
    return nil
  }
    
  fileprivate func matchStringPattern(baseURL: URL, htmlString: String, pattern: String) -> [String] {
    return htmlString.matches(for: pattern, group: 2)
  }
}
