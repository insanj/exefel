//
//  Scraper.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

class Scraper {
  struct Result {
    let games: [ResultGame]
  }
  
  struct ResultGame {
    let homeTeam: ResultTeam
    let awayTeam: ResultTeam
    let homeTeamWasWinner: Bool
  }
  
  struct ResultTeam {
    let name: String
    let abbreviation: String
  }
  
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
  }
  
  fileprivate func buildResult(baseURL url: URL, htmlString: String) -> Scraper.Result? {
    let subredditLeaderboardPattern =  #"<a class="(.*?)" rel="noopener" target="_blank" href="\/r\/(.*?)\/">"#
    let matches = matchStringPattern(baseURL: url, htmlString: htmlString, pattern: subredditLeaderboardPattern)
    return nil
  }
    
  fileprivate func matchStringPattern(baseURL: URL, htmlString: String, pattern: String) -> [String] {
    return htmlString.matches(for: pattern, group: 2)
  }
}
