//
//  WeekFiveResultBuilder.swift
//  exefel
//
//  Created by julian on 3/12/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

/* UP TO DATE AS OF THU 9:25 PM, 12 MARCH 2020 USING https://stats.xfl.com/Carousel */
class WeekFiveResultBuilder: ResultBuilder {
  static let PATH = "seed_2020_season_1_week_5"
  static let result: Scraper.Result = {
    guard let path = Bundle.main.path(forResource: PATH, ofType: "json") else {
      return Scraper.Result(games: [], created: Date())
    }
    
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      guard let games = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
        return Scraper.Result(games: [], created: Date())
      }
      
      let resultGames = games.compactMap {
        Scraper.ResultGame(Game(json: $0))
      }
      
      let result = Scraper.Result(games: resultGames, created: Date())
      return result
    }
    
    catch let e {
      return Scraper.Result(games: [], created: Date())
    }
  }()
  
  init() {
    super.init(WeekFiveResultBuilder.result)
  }
}
