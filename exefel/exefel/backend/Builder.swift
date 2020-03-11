//
//  Builder.swift
//  exefel
//
//  Created by julian on 3/10/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

protocol Builder {
  func buildDivisionsModel() -> TeamsViewController.Model
  func buildStandingsModel() -> TeamsViewController.Model
  func buildScheduleModel() -> StandingsViewController.GamesModel
}
