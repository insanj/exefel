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
  
  fileprivate var searchController: UISearchController?
  
  override init(model: TeamsViewController.Model?=StandingsViewController.buildDivisionsModel()) {
    super.init(model: model)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.keyboardDismissMode = .onDrag
    
    // setup search bar
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.hidesNavigationBarDuringPresentation = false
    search.searchResultsUpdater = self
    search.searchBar.placeholder = "Search 🏈 exefel, just now"
    search.searchBar.scopeButtonTitles = ["Divisions", "Standings", "Schedule"]
    search.searchBar.selectedScopeButtonIndex = 0
    search.searchBar.showsScopeBar = true
    search.searchBar.scopeBarBackgroundImage = UIImage.imageWithColor(UIColor.clear)
    search.searchBar.delegate = self
    
    self.extendedLayoutIncludesOpaqueBars = true
    
    // definesPresentationContext = true
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
}

extension StandingsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    if selectedScope == 0 {
      model = StandingsViewController.buildDivisionsModel()
    }
    
    else if selectedScope == 1 {
      model = StandingsViewController.buildStandingsModel()
    }
  }
}

extension StandingsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}
