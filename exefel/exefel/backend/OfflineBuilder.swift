//
//  OfflineBuilder.swift
//  exefel
//
//  Created by julian on 3/10/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class OfflineBuilder: Builder {
  
  func buildDivisionsModel() -> TeamsViewController.Model {
    
    let xflEast = TeamsViewController.ModelSection(title: "XFL East", footer: nil, items: {
      let battlehawks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "STL")?.resize(newWidth: 50.0), top: "St. Louis", middle: "Battlehawks", bottom: "3-1, 1st XFL East"), indicator: .disclosureIndicator, action: nil)
      let defenders = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DC")?.resize(newWidth: 50.0), top: "DC", middle: "Defenders", bottom: "2-2, 3rd XFL East"), indicator: .disclosureIndicator, action: nil)
      let guardians = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "NY")?.resize(newWidth: 50.0), top: "New York", middle: "Guardians", bottom: "3-2, 2nd XFL East"), indicator: .disclosureIndicator, action: nil)
      let vipers = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "TB")?.resize(newWidth: 50.0), top: "Tampa Bay", middle: "Vipers", bottom: "1-3, 4th XFL East"), indicator: .disclosureIndicator, action: nil)
      return [battlehawks, defenders, guardians, vipers]
    }())
    
    let xflWest = TeamsViewController.ModelSection(title: "XFL West", footer: nil, items: {
      let roughnecks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "HOU")?.resize(newWidth: 50.0), top: "Houston", middle: "Roughnecks", bottom: "5-0, 1st XFL West"), indicator: .disclosureIndicator, action: nil)
      let renegades = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DAL")?.resize(newWidth: 50.0), top: "Dallas", middle: "Renegades", bottom: "2-3, 2nd XFL West"), indicator: .disclosureIndicator, action: nil)
      let wildcats = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "LA")?.resize(newWidth: 50.0), top: "Los Angeles", middle: "Wildcats", bottom: "1-3, 3rd XFL West"), indicator: .disclosureIndicator, action: nil)
      let dragons = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "SEA")?.resize(newWidth: 50.0), top: "Seattle", middle: "Dragons", bottom: "1-4, 4th XFL West"), indicator: .disclosureIndicator, action: nil)
      return [dragons, renegades, roughnecks, wildcats]
    }())
    
    return TeamsViewController.Model(title: nil, sections: [xflEast, xflWest])
  }
  
  func buildStandingsModel() -> TeamsViewController.Model {
    
    let overall = TeamsViewController.ModelSection(title: "Overall", footer: nil, items: {
      let battlehawks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "STL")?.resize(newWidth: 50.0), top: "St. Louis", middle: "Battlehawks", bottom: "3-1, 1st XFL East"), indicator: .disclosureIndicator, action: nil)
      let defenders = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DC")?.resize(newWidth: 50.0), top: "DC", middle: "Defenders", bottom: "2-2, 3rd XFL East"), indicator: .disclosureIndicator, action: nil)
      let guardians = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "NY")?.resize(newWidth: 50.0), top: "New York", middle: "Guardians", bottom: "3-2, 2nd XFL East"), indicator: .disclosureIndicator, action: nil)
      let vipers = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "TB")?.resize(newWidth: 50.0), top: "Tampa Bay", middle: "Vipers", bottom: "1-3, 4th XFL East"), indicator: .disclosureIndicator, action: nil)
      let roughnecks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "HOU")?.resize(newWidth: 50.0), top: "Houston", middle: "Roughnecks", bottom: "5-0, 1st XFL West"), indicator: .disclosureIndicator, action: nil)
      let renegades = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DAL")?.resize(newWidth: 50.0), top: "Dallas", middle: "Renegades", bottom: "2-3, 2nd XFL West"), indicator: .disclosureIndicator, action: nil)
      let wildcats = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "LA")?.resize(newWidth: 50.0), top: "Los Angeles", middle: "Wildcats", bottom: "1-3, 3rd XFL West"), indicator: .disclosureIndicator, action: nil)
      let dragons = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "SEA")?.resize(newWidth: 50.0), top: "Seattle", middle: "Dragons", bottom: "1-4, 4th XFL West"), indicator: .disclosureIndicator, action: nil)
      return [roughnecks, battlehawks, guardians, defenders, renegades, wildcats, vipers, dragons]
    }())
    
    return TeamsViewController.Model(title: nil, sections: [overall])
  }
  
  func buildScheduleModel() -> StandingsViewController.GamesModel {
//    let sea = UIImage(named: "SEA")
//    let dc = UIImage(named: "DC")
//    let tb = UIImage(named: "TB")
//    let ny = UIImage(named: "NY")
//    let la = UIImage(named: "LA")
//    let hou = UIImage(named: "HOU")
//    let stl = UIImage(named: "STL")
//    let dal = UIImage(named: "DAL")
//
//    let weekOne = StandingsViewController.GamesSection(title: "Week One", cells: {
//      let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                   leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                   rightTop: "19-31",
//                                   rightBottom: "ABC")
//      let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: la, title: "LA Wildcats"),
//                                   leftBottom: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
//                                   rightTop: "17-37",
//                                   rightBottom: "FOX")
//      let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
//                                   leftBottom: GameCell.ModelSide(image: ny, title: "NY Guardians"),
//                                   rightTop: "3-23",
//                                   rightBottom: "FOX")
//      let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
//                                   leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
//                                   rightTop: "15-9",
//                                   rightBottom: "ESPN")
//      return [satMorn, satEve, sunMorn, sunEve]
//    }())
//
//    let weekTwo = StandingsViewController.GamesSection(title: "Week Two", cells: {
//     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
//                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                  rightTop: "0-27",
//                                  rightBottom: "ABC")
//     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
//                                  leftBottom: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                  rightTop: "9-17",
//                                  rightBottom: "FOX")
//     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
//                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
//                                  rightTop: "25-18",
//                                  rightBottom: "ABC")
//     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                  rightTop: "24-28",
//                                  rightBottom: "FS1")
//     return [satMorn, satEve, sunMorn, sunEve]
//    }())
//
//    let weekThree = StandingsViewController.GamesSection(title: "Week Three", cells: {
//     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
//                                  leftBottom: GameCell.ModelSide(image: tb, title: "TB Vipers"),
//                                  rightTop: "34-27",
//                                  rightBottom: "ABC")
//     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
//                                  leftBottom: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                  rightTop: "24-12",
//                                  rightBottom: "FOX")
//     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
//                                  leftBottom: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
//                                  rightTop: "9-29",
//                                  rightBottom: "ESPN")
//     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
//                                  rightTop: "9-39",
//                                  rightBottom: "FS1")
//     return [satMorn, satEve, sunMorn, sunEve]
//    }())
//
//    let weekFour = StandingsViewController.GamesSection(title: "Week Four", cells: {
//     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: la, title: "LA Wildcats"),
//                                  leftBottom: GameCell.ModelSide(image: ny, title: "NY Guardians"),
//                                  rightTop: "14-17",
//                                  rightBottom: "ABC")
//     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                  leftBottom: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
//                                  rightTop: "16-23",
//                                  rightBottom: "FOX")
//     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
//                                  leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
//                                  rightTop: "27-20",
//                                  rightBottom: "FS1")
//     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                  leftBottom: GameCell.ModelSide(image: tb, title: "TB Vipers"),
//                                  rightTop: "0-25",
//                                  rightBottom: "ESPN2")
//     return [satMorn, satEve, sunMorn, sunEve]
//    }())
//
//    let weekFive = StandingsViewController.GamesSection(title: "Week Five", cells: {
//     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
//                                  leftBottom: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
//                                  rightTop: "23-32",
//                                  rightBottom: "ABC")
//     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
//                                  leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
//                                  rightTop: "30-12",
//                                  rightBottom: "FOX")
//     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
//                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
//                                  rightTop: "3pm",
//                                  rightBottom: "FS1")
//     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
//                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
//                                  rightTop: "9pm",
//                                  rightBottom: "ESPN")
//     return [satMorn, satEve, sunMorn, sunEve]
//    }())
//
    /*
    let weekSix = GamesSection(title: "Week One", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekSeven = GamesSection(title: "Week One", cells: {
      let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
      let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
      let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
      let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
      return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekEight = GamesSection(title: "Week One", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekNine = GamesSection(title: "Week One", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekTen = GamesSection(title: "Week One", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "19-31",
                                  rightBottom: "ABC")
     return [satMorn, satEve, sunMorn, sunEve]
    }())*/
    
    return StandingsViewController.GamesModel(sections: [StandingsViewController.GamesSection(title: "Updating...", cells: [])]) //, weekSix, weekSeven, weekEight, weekNine, weekTen])
  }
  
}
