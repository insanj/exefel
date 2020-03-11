//
//  ResultBuilder.swift
//  exefel
//
//  Created by julian on 3/10/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class ResultBuilder: OfflineBuilder {
  let result: Scraper.Result
  
  init(_ result: Scraper.Result) {
    self.result = result
  }
  
  let sea = UIImage(named: "SEA")
  let dc = UIImage(named: "DC")
  let tb = UIImage(named: "TB")
  let ny = UIImage(named: "NY")
  let la = UIImage(named: "LA")
  let hou = UIImage(named: "HOU")
  let stl = UIImage(named: "STL")
  let dal = UIImage(named: "DAL")
  
  fileprivate func imageForTeam(abbr: String) -> UIImage? {
    return UIImage(named: abbr.uppercased())
  }
  
  override func buildScheduleModel() -> StandingsViewController.GamesModel {
    let weeks: [StandingsViewController.GamesSection] = {
      var weeksDict = [Int: [GameCell.Model]]()
      
      for game in result.games {
        let cell = GameCell.Model(underlying: game, leftTop: {
          return GameCell.ModelSide(image: imageForTeam(abbr: game.homeTeam.abbreviation), title: game.homeTeam.name)
        }(), leftBottom: {
          return GameCell.ModelSide(image: imageForTeam(abbr: game.awayTeam.abbreviation), title: game.awayTeam.name)
        }(), rightTop: {
          return "\(game.homeTeam.score)-\(game.awayTeam.score)"
        }(), rightBottom: {
          return "\(game.televisionNetwork)"
        }())
        
        if var gamesInWeek = weeksDict[game.weekNumber]  {
          gamesInWeek.append(cell)
          weeksDict[game.weekNumber] = gamesInWeek
        } else {
          weeksDict[game.weekNumber] = [cell]
        }
      }

      var weeksSections = [StandingsViewController.GamesSection]()
      weeksDict.forEach { (key, value) in
        let weekSec = StandingsViewController.GamesSection(title: "Week \(key)", cells: value)
        weeksSections.append(weekSec)
      }
      
      let sorted = weeksSections.sorted { (s1, s2) -> Bool in
        return s1.cells.first?.underlying?.weekNumber ?? 0 < s2.cells.first?.underlying?.weekNumber ?? 0
      }
      
      return sorted
    }()

    return StandingsViewController.GamesModel(sections: weeks)
  }
}
