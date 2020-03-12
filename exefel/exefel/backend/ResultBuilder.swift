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
        let top = GameCell.ModelSide(image: {
          return imageForTeam(abbr: game.awayTeam.abbreviation)
        }(), left: {
          return "\(game.awayTeam.abbreviation) \(game.underlying.awayTeamMascot ?? game.awayTeam.name)"
        }(), middle: {
          guard game.timeGameStarts.timeIntervalSinceNow <= 0 else {
            return ""
          }
          
          guard let s = game.underlying.awayScore else {
            return ""
          }
          return "\(s)"
        }(), right: {
          guard game.underlying.isGameOver != true else {
            return "Final"
          }
        
          guard game.timeGameStarts.timeIntervalSinceNow <= 0 else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d"
            let dayOfWeek = dateFormatter.string(from: game.timeGameStarts)
            dateFormatter.dateFormat = "ha"
            let hourOfDay = dateFormatter.string(from: game.timeGameStarts)
            return "\(dayOfWeek) \(hourOfDay.lowercased())"
          }
            
          guard let quarter = game.underlying.gameQuarter, let timeRemainingInQuarter = game.underlying.gameClock else {
            return ""
          }
          
          return "\(timeRemainingInQuarter) \(quarter)"
        }(), shouldBeBold: {
          return game.awayTeam.score > game.homeTeam.score
        }())
          
        let bottom = GameCell.ModelSide(image: {
          return imageForTeam(abbr: game.homeTeam.abbreviation)
        }(), left: {
          return "\(game.homeTeam.abbreviation) \(game.underlying.homeTeamMascot ?? game.homeTeam.name)"
        }(), middle: {
          guard game.timeGameStarts.timeIntervalSinceNow <= 0 else {
            return ""
          }

          guard let s = game.underlying.homeScore else {
            return ""
          }
          return "\(s)"
        }(), right: {
          return "\(game.televisionNetwork)"
        }(), shouldBeBold: {
          return game.homeTeam.score > game.awayTeam.score
        }())
        
        let cell = GameCell.Model(underlying: game, top: top, bottom: bottom)
        
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
        return s1.cells.first?.underlying.weekNumber ?? 0 < s2.cells.first?.underlying.weekNumber ?? 0
      }
      
      return sorted
    }()

    return StandingsViewController.GamesModel(sections: weeks)
  }
  
  struct StandingsTeam {
    let teamAbbr: String
    let teamLocation: String
    let teamName: String
    
    static let WEST = "West"
    static let EAST = "East"

    var teamDivision: String {
      if ["SEA", "DAL", "HOU", "LA"].contains(teamAbbr.uppercased()) {
        return StandingsTeam.WEST
      } else if ["STL", "DC", "NY", "TB"].contains(teamAbbr.uppercased()) {
        return StandingsTeam.EAST
      }
      
      return "??"
    }
  }
  
  override func buildStandingsModel() -> TeamsViewController.Model {
    var winLosses = [String: (Int, Int)]()
    var teamForAbbr = [String: StandingsTeam]()
    
    let endedGames = result.games.filter { $0.underlying.isGameOver == true }
    for game in endedGames {
      guard let resultAwayScore = game.underlying.awayScore, let resultHomeScore = game.underlying.homeScore else {
        continue
      }
      
      let homeIsWinner = resultHomeScore > resultAwayScore
      guard let winningAbbr = homeIsWinner ? game.underlying.homeTeamAbbr : game.underlying.awayTeamAbbr else {
        continue
      }
      
      guard let losingAbbr = homeIsWinner ? game.underlying.awayTeamAbbr : game.underlying.homeTeamAbbr else {
        continue
      }
      
      if let existingWinner = winLosses[winningAbbr] {
        winLosses[winningAbbr] = (existingWinner.0 + 1, existingWinner.1)
      } else {
        winLosses[winningAbbr] = (1, 0)
      }
      
      if let existingLoser = winLosses[losingAbbr] {
        winLosses[losingAbbr] = (existingLoser.0, existingLoser.1 + 1)
      } else {
        winLosses[losingAbbr] = (0, 1)
      }
      
      if homeIsWinner {
        teamForAbbr[winningAbbr] = StandingsTeam(teamAbbr: winningAbbr, teamLocation: game.underlying.homeTeamDisplayName ?? "??", teamName: game.underlying.homeTeamMascot ?? "??")
        teamForAbbr[losingAbbr] = StandingsTeam(teamAbbr: losingAbbr, teamLocation: game.underlying.awayTeamDisplayName ?? "", teamName: game.underlying.awayTeamMascot ?? "??")
      } else {
        teamForAbbr[winningAbbr] = StandingsTeam(teamAbbr: winningAbbr, teamLocation: game.underlying.awayTeamDisplayName ?? "??", teamName: game.underlying.awayTeamMascot ?? "??")
        teamForAbbr[losingAbbr] = StandingsTeam(teamAbbr: losingAbbr, teamLocation: game.underlying.homeTeamDisplayName ?? "", teamName: game.underlying.homeTeamMascot ?? "??")
      }
    }
        
    //var divisions = [String: [StandingsTeam]]()
    var westUnsorted = [StandingsTeam]()
    var eastUnsorted = [StandingsTeam]()
    
    teamForAbbr.forEach { (key, value) in
      if value.teamDivision == StandingsTeam.WEST {
        westUnsorted.append(value)
      } else if value.teamDivision == StandingsTeam.EAST {
        eastUnsorted.append(value)
      }
    }
    
    let westSorted = westUnsorted.sorted(by: { (t1, t2) -> Bool in
      guard let w1 = winLosses[t1.teamAbbr] else {
        return false
      }
      
      guard let w2 = winLosses[t2.teamAbbr] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    })
    
    let eastSorted = eastUnsorted.sorted(by: { (t1, t2) -> Bool in
      guard let w1 = winLosses[t1.teamAbbr] else {
        return false
      }
      
      guard let w2 = winLosses[t2.teamAbbr] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    })
    
    let sortedAbbrs: [String] = winLosses.keys.sorted { (k1, k2) -> Bool in
      guard let w1 = winLosses[k1] else {
        return false
      }
      
      guard let w2 = winLosses[k2] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    }
    
    let teams = sortedAbbrs.compactMap { (key) -> TeamsViewController.ModelItem? in
      let winLoss = winLosses[key] ?? (0, 0)
      
      var placeInDivision = "??"
      if teamForAbbr[key]?.teamDivision == StandingsTeam.WEST {
        placeInDivision = "\((westSorted.firstIndex(where: { $0.teamAbbr == key }) ?? 0) + 1)"
      } else if teamForAbbr[key]?.teamDivision == StandingsTeam.EAST {
        placeInDivision = "\((eastSorted.firstIndex(where: { $0.teamAbbr == key }) ?? 0) + 1)"
      }
      
      let cell = TeamCell.Model(image: imageForTeam(abbr: key),
                                top: teamForAbbr[key]?.teamLocation,
                                middle: teamForAbbr[key]?.teamName,
                                bottom: "\(winLoss.0)-\(winLoss.1), #\(placeInDivision) XFL \(teamForAbbr[key]?.teamDivision ?? "??")")
      
      return TeamsViewController.ModelItem(cell: cell, indicator: .none) { (vc) -> (Void) in
        // do nothing
      }
    }

    let overallSection = TeamsViewController.ModelSection(title: "Overall", footer: nil, items: teams)
    return TeamsViewController.Model(title: "Overall", sections: [overallSection])
  }
  
  override func buildDivisionsModel() -> TeamsViewController.Model {
    var winLosses = [String: (Int, Int)]()
    var teamForAbbr = [String: StandingsTeam]()
    
    let endedGames = result.games.filter { $0.underlying.isGameOver == true }
    for game in endedGames {
      guard let resultAwayScore = game.underlying.awayScore, let resultHomeScore = game.underlying.homeScore else {
        continue
      }
      
      let homeIsWinner = resultHomeScore > resultAwayScore
      guard let winningAbbr = homeIsWinner ? game.underlying.homeTeamAbbr : game.underlying.awayTeamAbbr else {
        continue
      }
      
      guard let losingAbbr = homeIsWinner ? game.underlying.awayTeamAbbr : game.underlying.homeTeamAbbr else {
        continue
      }
      
      if let existingWinner = winLosses[winningAbbr] {
        winLosses[winningAbbr] = (existingWinner.0 + 1, existingWinner.1)
      } else {
        winLosses[winningAbbr] = (1, 0)
      }
      
      if let existingLoser = winLosses[losingAbbr] {
        winLosses[losingAbbr] = (existingLoser.0, existingLoser.1 + 1)
      } else {
        winLosses[losingAbbr] = (0, 1)
      }
      
      if homeIsWinner {
        teamForAbbr[winningAbbr] = StandingsTeam(teamAbbr: winningAbbr, teamLocation: game.underlying.homeTeamDisplayName ?? "??", teamName: game.underlying.homeTeamMascot ?? "??")
        teamForAbbr[losingAbbr] = StandingsTeam(teamAbbr: losingAbbr, teamLocation: game.underlying.awayTeamDisplayName ?? "", teamName: game.underlying.awayTeamMascot ?? "??")
      } else {
        teamForAbbr[winningAbbr] = StandingsTeam(teamAbbr: winningAbbr, teamLocation: game.underlying.awayTeamDisplayName ?? "??", teamName: game.underlying.awayTeamMascot ?? "??")
        teamForAbbr[losingAbbr] = StandingsTeam(teamAbbr: losingAbbr, teamLocation: game.underlying.homeTeamDisplayName ?? "", teamName: game.underlying.homeTeamMascot ?? "??")
      }
    }
        
    //var divisions = [String: [StandingsTeam]]()
    var westUnsorted = [StandingsTeam]()
    var eastUnsorted = [StandingsTeam]()
    
    teamForAbbr.forEach { (key, value) in
      if value.teamDivision == StandingsTeam.WEST {
        westUnsorted.append(value)
      } else if value.teamDivision == StandingsTeam.EAST {
        eastUnsorted.append(value)
      }
    }
    
    let westSorted = westUnsorted.sorted(by: { (t1, t2) -> Bool in
      guard let w1 = winLosses[t1.teamAbbr] else {
        return false
      }
      
      guard let w2 = winLosses[t2.teamAbbr] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    })
    
    let eastSorted = eastUnsorted.sorted(by: { (t1, t2) -> Bool in
      guard let w1 = winLosses[t1.teamAbbr] else {
        return false
      }
      
      guard let w2 = winLosses[t2.teamAbbr] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    })
    
    let sortedAbbrs: [String] = winLosses.keys.sorted { (k1, k2) -> Bool in
      guard let w1 = winLosses[k1] else {
        return false
      }
      
      guard let w2 = winLosses[k2] else {
        return true
      }
      
      return w1.0 - w1.1 > w2.0 - w2.1
    }
    
    let westTeams = westSorted.compactMap { (t) -> TeamsViewController.ModelItem? in
      let key = t.teamAbbr
      let winLoss = winLosses[key] ?? (0, 0)
      
      let placeInXFL = (sortedAbbrs.firstIndex(of: key) ?? 0) + 1
      let cell = TeamCell.Model(image: imageForTeam(abbr: key),
                                top: teamForAbbr[key]?.teamLocation,
                                middle: teamForAbbr[key]?.teamName,
                                bottom: "\(winLoss.0)-\(winLoss.1), #\(placeInXFL) Overall")
      
      return TeamsViewController.ModelItem(cell: cell, indicator: .none) { (vc) -> (Void) in
        // do nothing
      }
    }
    
    let eastTeams = eastSorted.compactMap { (t) -> TeamsViewController.ModelItem? in
      let key = t.teamAbbr
      let winLoss = winLosses[key] ?? (0, 0)
      
      let placeInXFL = (sortedAbbrs.firstIndex(of: key) ?? 0) + 1
      let cell = TeamCell.Model(image: imageForTeam(abbr: key),
                                top: teamForAbbr[key]?.teamLocation,
                                middle: teamForAbbr[key]?.teamName,
                                bottom: "\(winLoss.0)-\(winLoss.1), #\(placeInXFL) Overall")
      
      return TeamsViewController.ModelItem(cell: cell, indicator: .none) { (vc) -> (Void) in
        // do nothing
      }
    }

    let westSection = TeamsViewController.ModelSection(title: "XFL West", footer: nil, items: westTeams)
    let eastSection = TeamsViewController.ModelSection(title: "XFL East", footer: nil, items: eastTeams)
    return TeamsViewController.Model(title: "Overall", sections: [eastSection, westSection])
  }
}
