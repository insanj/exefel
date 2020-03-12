//
//  Game.swift
//  exefel
//
//  Created by julian on 3/10/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

class Game {
  class Key {
    static let awayScore = "awayScore" // 19
    static let awayTeamAbbr = "awayTeamAbbr" // SEA
    static let awayTeamDisplayName = "awayTeamDisplayName" //"Seattle"
    static let awayTeamId = "awayTeamId" // 603
    static let awayTeamMascot = "awayTeamMascot" // "Dragons"
    static let awayTeamName = "awayTeamName" // "Seattle Dragons"
    static let awayTimeoutsRemaining = "awayTimeoutsRemaining" // : 0
    static let awayTimeoutsUsed = "awayTimeoutsUsed" // : 2
    static let ballLocation = "ballLocation" // : "DC 44"
    static let gameClock = "gameClock" // : "00:00"
    static let gameId = "gameId" // : 1
    static let gameLocalStartDate = "gameLocalStartDate" // : "2020-02-08T14:00:00"
    static let gameNumber = "gameNumber" // : 1
    static let gameQuarter = "gameQuarter" // : 4
    static let gameStartDateTimeET = "gameStartDateTimeET" // : "2020-02-08T14:00:00"
    static let gameStartTimestampUTC = "gameStartTimestampUTC" // : "2020-02-08T19:00:00"
    static let gameStatus = "gameStatus" // : "CLSD"
    static let gameStatusID = "gameStatusID" // : 12
    static let homeScore = "homeScore" // : 31
    static let homeTeamAbbr = "homeTeamAbbr" //: "DC"
    static let homeTeamDisplayName = "homeTeamDisplayName" // : "DC"
    static let homeTeamId = "homeTeamId" //: 604
    static let homeTeamMascot = "homeTeamMascot" // : "Defenders"
    static let homeTeamName = "homeTeamName" // : "DC Defenders"
    static let homeTimeoutsRemaining = "homeTimeoutsRemaining" // : 2
    static let homeTimeoutsUsed = "homeTimeoutsUsed" //: 0
    static let isGameLive = "isGameLive" // : false
    static let isGameOver = "isGameOver" // : true
    static let isGameOverTime = "isGameOverTime" // : false
    static let isScoreFinal = "isScoreFinal" // : true
    static let leagueId = "leagueId" // : 130
    static let leagueLevelId = "leagueLevelId" //: 60
    static let leagueName = "leagueName" //: "XFL"
    static let network = "network" //: "ABC"
    static let playDistance = "playDistance" //: 15
    static let playDown = "playDown" //: 4
    static let playDownFormatted = "playDownFormatted" //: "4th"
    static let possessionId = "possessionId" //: 604
    static let resultAwayScore = "resultAwayScore" //: 19
    static let resultFinishType = "resultFinishType" //: "Regular Time"
    static let resultHomeScore = "resultHomeScore" // : 31
    static let resultWinner = "resultWinner" //: "DC Defenders"
    static let seasonEndTimestampUTC = "seasonEndTimestampUTC" //: "2020-04-26T00:00:00"
    static let seasonId = "seasonId" // : 2
    static let seasonName = "seasonName" // XFL 2020"
    static let seasonPhaseCode = "seasonPhaseCode" //: null
    static let seasonPhaseId = "seasonPhaseId" // : 600
    static let seasonPhaseName = "seasonPhaseName" //: "XFL 2020 Regular Season"
    static let seasonPhaseShortName = "seasonPhaseShortName" //: null
    static let seasonPhaseTypeCode = "seasonPhaseTypeCode" // : null
    static let seasonPhaseTypeDescription = "seasonPhaseTypeDescription" //: null
    static let seasonPhaseTypeName = "seasonPhaseTypeName" //: null
    static let seasonStartTimestampUTC = "seasonStartTimestampUTC" //: "2020-02-08T00:00:00"
    static let seasonYear = "seasonYear" // : 2020
    static let showInCarousel = "showInCarousel" //: true
    static let venueId = "venueId" //: 0
    static let weekEndTimestampUTC = "weekEndTimestampUTC" //: "2020-02-10T08:00:00"
    static let weekId = "weekId" //: 1
    static let weekNumber = "weekNumber" //: 1
    static let weekSequence = "weekSequence" //: 1
    static let weekStartTimestampUTC = "weekStartTimestampUTC" //: "2020-02-08T19:0
  }
  
  let json: [String: Any]
  
  init(json: [String: Any]) {
    self.json = json
  }
  
  var gameStartTimestampUTC: String? {
    return json[Key.gameStartTimestampUTC] as? String
  }

  var network: String? {
    return json[Key.network] as? String
  }
  
  var homeTeamName: String? {
    return json[Key.homeTeamName] as? String
  }
  
  var homeTeamMascot: String? {
    return json[Key.homeTeamMascot] as? String
  }
  
  var homeTeamAbbr: String? {
    return json[Key.homeTeamAbbr] as? String
  }
  
  var homeScore: Int? {
    return json[Key.homeScore] as? Int
  }
  
  var awayTeamName: String? {
    return json[Key.awayTeamName] as? String
  }
  
  var awayTeamAbbr: String? {
    return json[Key.awayTeamAbbr] as? String
  }
  
  var awayTeamMascot: String? {
    return json[Key.awayTeamMascot] as? String
  }
  
  var awayScore: Int? {
    return json[Key.awayScore] as? Int
  }
  
  var weekNumber: Int? {
    return json[Key.weekNumber] as? Int
  }
  
  var resultHomeScore: Int? {
    return json[Key.resultHomeScore] as? Int
  }
  
  var resultAwayScore: Int? {
    return json[Key.resultAwayScore] as? Int
  }
  
  var awayTeamDisplayName: String? {
    return json[Key.awayTeamDisplayName] as? String
  }
  
  var homeTeamDisplayName: String? {
    return json[Key.homeTeamDisplayName] as? String
  }
  
  var isGameOver: Bool? {
    return json[Key.isGameOver] as? Bool
  }
  
  var gameQuarter: Int? {
    return json[Key.gameQuarter] as? Int
  }
  
  var gameClock: String? {
    return json[Key.gameClock] as? String
  }
}
