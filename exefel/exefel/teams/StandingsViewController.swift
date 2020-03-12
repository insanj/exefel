//
//  StandingsViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class StandingsViewController: TeamsViewController {
  struct GamesModel {
    let sections: [GamesSection]
  }
  
  struct GamesSection {
    let title: String?
    let cells: [GameCell.Model]
  }
  
  internal var builder = OfflineBuilder()
  internal var backingModel: TeamsViewController.Model // StandingsViewController.buildDivisionsModel()
  internal var backingGamesModel: StandingsViewController.GamesModel //StandingsViewController.buildScheduleModel()
  internal var gamesModel: GamesModel? {
    didSet {
      tableView.reloadData()
    }
  }

  fileprivate var searchController: UISearchController?
  
  init() {
    backingModel = builder.buildDivisionsModel()
    backingGamesModel = builder.buildScheduleModel()
    super.init(model: backingModel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.allowsSelection = false
    tableView.keyboardDismissMode = .onDrag
    tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseIdentifier)
    
    // setup search bar
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.hidesNavigationBarDuringPresentation = false
    search.searchResultsUpdater = self
    // search.delegate = self
    search.searchBar.placeholder = "Updating 🏈 exefel..."
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
      guard let result = result else {
        return
      }
      

      let resultBuilder = ResultBuilder(result)
      self.builder = resultBuilder
      
      if let searchBar = self.searchController?.searchBar {
        searchBar.placeholder = "Search 🏈 exefel, pull to refresh"

        self.searchBar(searchBar, selectedScopeButtonIndexDidChange: searchBar.selectedScopeButtonIndex)
      }
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
    
    guard let header = gamesModel?.sections[section].title else {
      return nil
    }
    
    return "   \(header)"
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
  
  fileprivate var loadWhenDoneDragging = false
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if loadWhenDoneDragging == false, let search = self.searchController, search.searchBar.placeholder != "Updating 🏈 exefel...", scrollView.contentOffset.y < -(view.safeAreaInsets.top + 100.0) {
      loadWhenDoneDragging = true
      self.searchController?.searchBar.placeholder = "Release to refresh 🏈 exefel!"
    }
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if loadWhenDoneDragging {
      self.searchController?.searchBar.placeholder = "Updating 🏈 exefel..."
      loadWhenDoneDragging = false
      reloadBackend()
    }

  }
}

extension StandingsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    if selectedScope == 0 {
      backingModel = builder.buildDivisionsModel()
      model = backingModel
    }
    
    else if selectedScope == 1 {
      backingModel = builder.buildStandingsModel()
      model = backingModel
    }
    
    else if selectedScope == 2 {
      backingGamesModel = builder.buildScheduleModel()
      gamesModel = backingGamesModel
      
      let mostUpToDateWeekIndexPath: IndexPath? = {
//        let mostRecentSorted = backingGamesModel.sections.sorted { (s1, s2) -> Bool in
////          guard let t1 = s1.cells.first?.underlying.timeGameStarts.timeIntervalSinceNow else {
////            return false
////          }
////          guard let t2 = s2.cells.first?.underlying.timeGameStarts.timeIntervalSinceNow else {
////            return true
////          }
//
//          //return t1 > t2
//
//          return (s1.cells.first?.underlying.isGameOver ?? <#default value#>)
//        }
        
        let tableViewIndexForMostRecentSec = backingGamesModel.sections.firstIndex { (s) -> Bool in
          guard let overStatus = s.cells.first?.underlying.underlying.isGameOver else {
            return false
          }
          return overStatus == false //s.title == mostRecentSorted.first?.title // TODO real equality comparison using Hashable/Equatable?
        }
        
        guard let sec = tableViewIndexForMostRecentSec else {
          return nil
        }
        
        return IndexPath(row: 0, section: sec)
      }()
        
      if let indexPath = mostUpToDateWeekIndexPath {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
      }
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
