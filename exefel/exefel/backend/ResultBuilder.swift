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
    let overallWins: Int
    let overallLosses: Int
    let divisionWins: Int
    let divisionLosses: Int
    
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
    
    init(teamAbbr: String?=nil, teamLocation: String?=nil, teamName: String?=nil, overallWins: Int=0, overallLosses: Int=0, divisionWins: Int=0, divisionLosses: Int=0) {
      self.teamAbbr = teamAbbr ?? "??"
      self.teamLocation = teamLocation ?? "??"
      self.teamName = teamName ?? "??"
      self.overallWins = overallWins
      self.overallLosses = overallLosses
      self.divisionWins = divisionWins
      self.divisionLosses = divisionLosses
    }
    
    func with(overallWins newOverallWins: Int?=nil, overallLosses newOverallLosses: Int?=nil, divisionWins newDivisionWins: Int?=nil, divisionLosses newDivisionLosses: Int?=nil) -> StandingsTeam {
      return StandingsTeam(teamAbbr: teamAbbr, teamLocation: teamLocation, teamName: teamName, overallWins: newOverallWins ?? overallWins, overallLosses: newOverallLosses ?? overallLosses, divisionWins: newDivisionWins ?? divisionWins, divisionLosses: newDivisionLosses ?? divisionLosses)
    }
    
    func adding(overallWins newOverallWins: Int=0, overallLosses newOverallLosses: Int=0, divisionWins newDivisionWins: Int=0, divisionLosses newDivisionLosses: Int=0) -> StandingsTeam {
      return StandingsTeam(teamAbbr: teamAbbr, teamLocation: teamLocation, teamName: teamName, overallWins: overallWins + newOverallWins, overallLosses: overallLosses + newOverallLosses, divisionWins: divisionWins + newDivisionWins, divisionLosses: divisionLosses + newDivisionLosses)
    }
  }
  
  fileprivate struct BuiltStandingsTeams {
    let overall: [StandingsTeam]
    let east: [StandingsTeam]
    let west: [StandingsTeam]
  }
  
  fileprivate func buildStandingsTeams() -> BuiltStandingsTeams {
    var teams = [StandingsTeam]()
    let endedGames = result.games.compactMap({ $0.underlying }).filter({ $0.isGameOver == true })
    for game in endedGames {
      guard let resultAwayScore = game.awayScore, let resultHomeScore = game.homeScore else {
        continue
      }
       
      let homeIsWinner = resultHomeScore > resultAwayScore
      var winningTeam: StandingsTeam, losingTeam: StandingsTeam
      if homeIsWinner {
        winningTeam = StandingsTeam(teamAbbr: game.homeTeamAbbr,
                                    teamLocation: game.homeTeamDisplayName,
                                    teamName: game.homeTeamMascot)
         
        losingTeam = StandingsTeam(teamAbbr: game.awayTeamAbbr,
                                    teamLocation: game.awayTeamDisplayName,
                                    teamName: game.awayTeamMascot)
      } else {
        winningTeam = StandingsTeam(teamAbbr: game.awayTeamAbbr,
                                    teamLocation: game.awayTeamDisplayName,
                                    teamName: game.awayTeamMascot)
         
        losingTeam = StandingsTeam(teamAbbr: game.homeTeamAbbr,
                                    teamLocation: game.homeTeamDisplayName,
                                    teamName: game.homeTeamMascot)
      }
       
      if let existingWinning = teams.first(where: { $0.teamAbbr == winningTeam.teamAbbr }) {
        winningTeam = existingWinning
        teams.removeAll { $0.teamAbbr == winningTeam.teamAbbr }
      }
       
      if let existingLosing = teams.first(where: { $0.teamAbbr == losingTeam.teamAbbr }) {
        losingTeam = existingLosing
        teams.removeAll { $0.teamAbbr == losingTeam.teamAbbr }
      }
       
      let finishedWinning = winningTeam.adding(overallWins: 1, divisionWins: winningTeam.teamDivision == losingTeam.teamDivision ? 1 : 0)
      let finishedLosing = losingTeam.adding(overallLosses: 1, divisionLosses: winningTeam.teamDivision == losingTeam.teamDivision ? 1 : 0)
       
      teams.append(finishedWinning)
      teams.append(finishedLosing)
    }
         
    let westUnsorted = teams.filter { $0.teamDivision == StandingsTeam.WEST }
    let eastUnsorted = teams.filter { $0.teamDivision == StandingsTeam.EAST }
     
    let divisionSorter: (ResultBuilder.StandingsTeam, ResultBuilder.StandingsTeam) -> Bool = { t1, t2 in
      let d1 = t1.divisionWins - t1.divisionLosses, d2 = t2.divisionWins - t2.divisionLosses
      let o1 = t1.overallWins - t1.overallLosses, o2 = t2.overallWins - t2.overallLosses
      if d1 == d2 {
        return o1 > o2
      }
//      } else if o2 - o1 > 2 { // if overall differential is > 2, then choose the better team
//        return false
//      } else if o1 - o2 > 2 {
//        return true
//      }
      return d1 > d2
    }
    
    let westSorted = westUnsorted.sorted(by: divisionSorter)
    let eastSorted = eastUnsorted.sorted(by: divisionSorter)
    let sortedTeams = teams.sorted { (t1, t2) -> Bool in
      return t1.overallWins - t1.overallLosses > t2.overallWins - t2.overallLosses
    }
    
    return BuiltStandingsTeams(overall: sortedTeams, east: eastSorted, west: westSorted)
  }
  
  override func buildStandingsModel() -> TeamsViewController.Model {
    let built = buildStandingsTeams()
    let sortedTeams = built.overall, westSorted = built.west, eastSorted = built.east
    
    let teamModels = sortedTeams.compactMap { (team) -> TeamsViewController.ModelItem? in
      let winLoss = (team.overallWins, team.overallLosses)
      
      var placeInDivision = "??"
      if team.teamDivision == StandingsTeam.WEST {
        placeInDivision = "\((westSorted.firstIndex(where: { $0.teamAbbr == team.teamAbbr }) ?? 0) + 1)"
      } else if team.teamDivision == StandingsTeam.EAST {
        placeInDivision = "\((eastSorted.firstIndex(where: { $0.teamAbbr == team.teamAbbr }) ?? 0) + 1)"
      }
      
      let cell = TeamCell.Model(image: imageForTeam(abbr: team.teamAbbr),
                                top: team.teamLocation,
                                middle: team.teamName,
                                bottom: "\(winLoss.0)-\(winLoss.1), #\(placeInDivision) XFL \(team.teamDivision )")
      
      return TeamsViewController.ModelItem(cell: cell, indicator: .none) { (vc) -> (Void) in
        // do nothing
      }
    }

    let overallSection = TeamsViewController.ModelSection(title: "Overall", footer: nil, items: teamModels)
    return TeamsViewController.Model(title: "Overall", sections: [overallSection])
  }
  
  override func buildDivisionsModel() -> TeamsViewController.Model {
    let built = buildStandingsTeams()
    let sortedTeams = built.overall, westSorted = built.west, eastSorted = built.east
    
    let transformer: (StandingsTeam) -> (TeamsViewController.ModelItem?) = { team in
      let placeInXFL = (sortedTeams.firstIndex(where: { $0.teamAbbr == team.teamAbbr }) ?? 0) + 1
      let cell = TeamCell.Model(image: self.imageForTeam(abbr: team.teamAbbr),
                                top: team.teamLocation,
                                middle: team.teamName,
                                bottom: "\(team.overallWins)-\(team.overallLosses) (\(team.divisionWins)-\(team.divisionLosses)), #\(placeInXFL) Overall")
      
      return TeamsViewController.ModelItem(cell: cell, indicator: .none) { (vc) -> (Void) in
        // do nothing
      }
    }
    
    let westTeams = westSorted.compactMap(transformer)
    let eastTeams = eastSorted.compactMap(transformer)

    let westSection = TeamsViewController.ModelSection(title: "XFL West", footer: nil, items: westTeams)
    let eastSection = TeamsViewController.ModelSection(title: "XFL East", footer: nil, items: eastTeams)
    return TeamsViewController.Model(title: "Overall", sections: [eastSection, westSection])
  }
}
