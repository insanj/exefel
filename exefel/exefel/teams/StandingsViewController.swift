//
//  StandingsViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class StandingsViewController: TeamsViewController {
  
  static func buildDivisionsModel() -> TeamsViewController.Model {
    
    let xflEast = TeamsViewController.ModelSection(title: "XFL East", footer: nil, items: {
      let battlehawks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "STL")?.resize(newWidth: 50.0), top: "St. Louis", middle: "Battlehawks", bottom: "3-1, 1st XFL East"), indicator: .disclosureIndicator, action: nil)
      let defenders = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DC")?.resize(newWidth: 50.0), top: "DC", middle: "Defenders", bottom: "2-2, 3rd XFL East"), indicator: .disclosureIndicator, action: nil)
      let guardians = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "NY")?.resize(newWidth: 50.0), top: "New York", middle: "Guardians", bottom: "3-2, 2nd XFL East"), indicator: .disclosureIndicator, action: nil)
      let vipers = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "TB")?.resize(newWidth: 50.0), top: "Tampa Bay", middle: "Vipers", bottom: "1-3, 4th XFL East"), indicator: .disclosureIndicator, action: nil)
      return [battlehawks, defenders, guardians, vipers]
    }())
    
    // "v\(Bundle.main.version ?? "??")-\(Bundle.main.build ?? "??") from \(DateFormatter.localizedString(from: Bundle.main.buildDate ?? Date(), dateStyle: .short, timeStyle: .short))"
    let xflWest = TeamsViewController.ModelSection(title: "XFL West", footer: nil, items: {
      let roughnecks = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "HOU")?.resize(newWidth: 50.0), top: "Houston", middle: "Roughnecks", bottom: "5-0, 1st XFL West"), indicator: .disclosureIndicator, action: nil)
      let renegades = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "DAL")?.resize(newWidth: 50.0), top: "Dallas", middle: "Renegades", bottom: "2-3, 2nd XFL West"), indicator: .disclosureIndicator, action: nil)
      let wildcats = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "LA")?.resize(newWidth: 50.0), top: "Los Angeles", middle: "Wildcats", bottom: "1-3, 3rd XFL West"), indicator: .disclosureIndicator, action: nil)
      let dragons = TeamsViewController.ModelItem(cell: TeamCell.Model(image: UIImage(named: "SEA")?.resize(newWidth: 50.0), top: "Seattle", middle: "Dragons", bottom: "1-4, 4th XFL West"), indicator: .disclosureIndicator, action: nil)
      return [dragons, renegades, roughnecks, wildcats]
    }())
    
    return TeamsViewController.Model(title: nil, sections: [xflEast, xflWest])
  }
  
  static func buildStandingsModel() -> TeamsViewController.Model {
    
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
  
  struct GamesModel {
    let sections: [GamesSection]
  }
  
  struct GamesSection {
    let title: String?
    let cells: [GameCell.Model]
  }
  
  static func buildScheduleModel() -> StandingsViewController.GamesModel {
    let sea = UIImage(named: "SEA")
    let dc = UIImage(named: "DC")
    let tb = UIImage(named: "TB")
    let ny = UIImage(named: "NY")
    let la = UIImage(named: "LA")
    let hou = UIImage(named: "HOU")
    let stl = UIImage(named: "STL")
    let dal = UIImage(named: "DAL")

    let weekOne = GamesSection(title: "Week One", cells: {
      let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                   leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                   rightTop: "19-31",
                                   rightBottom: "ABC")
      let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: la, title: "LA Wildcats"),
                                   leftBottom: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
                                   rightTop: "17-37",
                                   rightBottom: "FOX")
      let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
                                   leftBottom: GameCell.ModelSide(image: ny, title: "NY Guardians"),
                                   rightTop: "3-23",
                                   rightBottom: "FOX")
      let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
                                   leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
                                   rightTop: "15-9",
                                   rightBottom: "ESPN")
      return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekTwo = GamesSection(title: "Week Two", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "0-27",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
                                  leftBottom: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  rightTop: "9-17",
                                  rightBottom: "FOX")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
                                  rightTop: "25-18",
                                  rightBottom: "ABC")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "24-28",
                                  rightBottom: "FS1")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekThree = GamesSection(title: "Week Three", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
                                  leftBottom: GameCell.ModelSide(image: tb, title: "TB Vipers"),
                                  rightTop: "34-27",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
                                  leftBottom: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  rightTop: "24-12",
                                  rightBottom: "FOX")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
                                  leftBottom: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
                                  rightTop: "9-29",
                                  rightBottom: "ESPN")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
                                  rightTop: "9-39",
                                  rightBottom: "FS1")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekFour = GamesSection(title: "Week Four", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: la, title: "LA Wildcats"),
                                  leftBottom: GameCell.ModelSide(image: ny, title: "NY Guardians"),
                                  rightTop: "14-17",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
                                  rightTop: "16-23",
                                  rightBottom: "FOX")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
                                  leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
                                  rightTop: "27-20",
                                  rightBottom: "FS1")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  leftBottom: GameCell.ModelSide(image: tb, title: "TB Vipers"),
                                  rightTop: "0-25",
                                  rightBottom: "ESPN2")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
    let weekFive = GamesSection(title: "Week Five", cells: {
     let satMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: sea, title: "SEA Dragons"),
                                  leftBottom: GameCell.ModelSide(image: hou, title: "HOU Roughnecks"),
                                  rightTop: "23-32",
                                  rightBottom: "ABC")
     let satEve = GameCell.Model(leftTop: GameCell.ModelSide(image: ny, title: "NY Guardians"),
                                  leftBottom: GameCell.ModelSide(image: dal, title: "DAL Renegades"),
                                  rightTop: "30-12",
                                  rightBottom: "FOX")
     let sunMorn = GameCell.Model(leftTop: GameCell.ModelSide(image: stl, title: "STL Battlehawks"),
                                  leftBottom: GameCell.ModelSide(image: dc, title: "DC Defenders"),
                                  rightTop: "3pm",
                                  rightBottom: "FS1")
     let sunEve = GameCell.Model(leftTop: GameCell.ModelSide(image: tb, title: "TB Vipers"),
                                  leftBottom: GameCell.ModelSide(image: la, title: "LA Wildcats"),
                                  rightTop: "9pm",
                                  rightBottom: "ESPN")
     return [satMorn, satEve, sunMorn, sunEve]
    }())
    
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
    
    return StandingsViewController.GamesModel(sections: [weekOne, weekTwo, weekThree, weekFour, weekFive])//, weekSix, weekSeven, weekEight, weekNine, weekTen])
  }
  
  internal var backingModel = StandingsViewController.buildDivisionsModel()
  internal var backingGamesModel = StandingsViewController.buildScheduleModel()
  internal var gamesModel: GamesModel? {
    didSet {
      tableView.reloadData()
    }
  }

  fileprivate var searchController: UISearchController?
  
  init() {
    super.init(model: backingModel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.keyboardDismissMode = .onDrag
    tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseIdentifier)
    
    // setup search bar
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.hidesNavigationBarDuringPresentation = false
    search.searchResultsUpdater = self
    // search.delegate = self
    search.searchBar.placeholder = "Search 🏈 exefel, just now"
    search.searchBar.scopeButtonTitles = ["Divisions", "Standings", "Schedule"]
    search.searchBar.selectedScopeButtonIndex = 0
    search.searchBar.showsScopeBar = true
    search.searchBar.scopeBarBackgroundImage = UIImage.imageWithColor(UIColor.clear)
    search.searchBar.delegate = self
    search.searchBar.showsCancelButton = false
    
    extendedLayoutIncludesOpaqueBars = true
    definesPresentationContext = true
    navigationItem.titleView = search.searchBar
    search.searchBar.sizeToFit()
    
    searchController = search
  }
  
  override func reloadBackend() {
    let scraper = Scraper()
    scraper.get() { result in
      print(result)
      // self.model = ViewController.Model(result: result)
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.numberOfSections(in: tableView)
    }
    
    return gamesModel?.sections.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.tableView(tableView, titleForHeaderInSection: section)
    }
    
    return gamesModel?.sections[section].title
  }
  
  override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.tableView(tableView, titleForFooterInSection: section)
    }
    
    return nil
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    return gamesModel?.sections[section].cells.count ?? 0

  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    return GameCell.height
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseIdentifier, for: indexPath)
    guard let gameCell = cell as? GameCell else {
      return cell
    }
    
    guard let item = gamesModel?.sections[indexPath.section].cells[indexPath.row] else {
      return gameCell
    }
    
    gameCell.model = item
    return gameCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard searchController?.searchBar.selectedScopeButtonIndex == 2 else {
      super.tableView(tableView, didSelectRowAt: indexPath)
      return
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension StandingsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    if selectedScope == 0 {
      backingModel = StandingsViewController.buildDivisionsModel()
      model = backingModel
    }
    
    else if selectedScope == 1 {
      backingModel = StandingsViewController.buildStandingsModel()
      model = backingModel
    }
    
    else if selectedScope == 2 {
      backingGamesModel = StandingsViewController.buildScheduleModel()
      gamesModel = backingGamesModel
    }
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchController?.searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      guard let text = self.searchController?.searchBar.text, text.count > 0 else {
        self.searchController?.searchBar.setShowsCancelButton(false, animated: true)
        return
      }
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    guard searchBar.isFirstResponder else {
      self.searchController?.searchBar.setShowsCancelButton(false, animated: true)
      return
    }
  }
}

extension StandingsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let selectedScope = searchController.searchBar.selectedScopeButtonIndex
    guard let searchText = searchController.searchBar.text, searchText.count > 0 else {
      if selectedScope == 2 {
        gamesModel = backingGamesModel
      } else {
        model = backingModel
      }
      return
    }
        
    if selectedScope == 0 {
      model = TeamsViewController.Model(title: backingModel.title, sections: backingModel.sections.compactMap({ (section) -> TeamsViewController.ModelSection? in
        return TeamsViewController.ModelSection(title: section.title, footer: section.footer, items: section.items.filter({ (item) -> Bool in
          return item.cell.matches(text: searchText)
        }))
      }))
    }
    
    else if selectedScope == 1 {
      model = TeamsViewController.Model(title: backingModel.title, sections: backingModel.sections.compactMap({ (section) -> TeamsViewController.ModelSection? in
        return TeamsViewController.ModelSection(title: section.title, footer: section.footer, items: section.items.filter({ (item) -> Bool in
          return item.cell.matches(text: searchText)
        }))
      }))
    }
    
    else if selectedScope == 2 {
      gamesModel = StandingsViewController.GamesModel(sections: backingGamesModel.sections.compactMap({ (section) -> StandingsViewController.GamesSection? in
        return StandingsViewController.GamesSection(title: section.title, cells: section.cells.filter({ (item) -> Bool in
          return item.matches(text: searchText)
        }))
      }))
    }
  }
}
