//
//  StandingsViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class StandingsViewController: TeamsViewController {
//  static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
//    return StandingsViewController(coder: coder)
//  }
  
  struct GamesModel {
    let sections: [GamesSection]
  }
  
  struct GamesSection {
    let title: String?
    let cells: [GameCell.Model]
  }
  
  static let restorationIdentifier = String(describing: StandingsViewController.self) + "RestorationIdentifier"

  internal var builder: Builder = WeekFiveResultBuilder()
  internal var backingModel: TeamsViewController.Model
  internal var backingGamesModel: StandingsViewController.GamesModel
  
  internal var gamesModel: GamesModel? {
    didSet {
      tableView.reloadData()
      
      guard searchController?.searchBar.isFirstResponder != true else {
        return // do not scroll to top if we are currently searching
      }
      
      let mostUpToDateWeekIndexPath: IndexPath? = {
        let tableViewIndexForMostRecentSec = gamesModel?.sections.firstIndex { (s) -> Bool in
          guard let overStatus = s.cells.first?.underlying.underlying.isGameOver else {
            return false
          }
          return overStatus == false
        }
        
        guard let sec = tableViewIndexForMostRecentSec, sec < gamesModel?.sections.count ?? 0 else {
          return nil
        }
        
        return IndexPath(row: 0, section: sec)
      }()
        
      if let indexPath = mostUpToDateWeekIndexPath {
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
      }
    }
  }

  fileprivate var searchController: UISearchController?
  fileprivate let feedbackGenerator = UISelectionFeedbackGenerator()
  
  init() {
    backingModel = builder.buildDivisionsModel()
    backingGamesModel = builder.buildScheduleModel()
    super.init(model: backingModel)
  }
  
  required init?(coder: NSCoder) {
    backingModel = builder.buildDivisionsModel()
    backingGamesModel = builder.buildScheduleModel()
    super.init(model: backingModel)
    decodeRestorableState(with: coder)
  }
  
  class RestorableStateKey {
    static let selectedSegmentIndex = "selectedSegmentIndex"
  }
  
  internal var decodedSegementedIndex: Int? {
    didSet {
      if let d = decodedSegementedIndex {
        self.searchController?.searchBar.selectedScopeButtonIndex = d
      }
    }
  }
  
  override func encodeRestorableState(with coder: NSCoder) {
    super.encodeRestorableState(with: coder)
    
    if let encodable = self.searchController?.searchBar.selectedScopeButtonIndex {
      coder.encode(encodable, forKey:RestorableStateKey.selectedSegmentIndex)
    }
  }
  
  override func decodeRestorableState(with coder: NSCoder) {
    decodedSegementedIndex = coder.decodeInteger(forKey: RestorableStateKey.selectedSegmentIndex)
    
    if decodedSegementedIndex != searchController?.searchBar.selectedScopeButtonIndex {
      if decodedSegementedIndex == 0 {
        backingModel = builder.buildDivisionsModel()
        model = backingModel
      }
      
      else if decodedSegementedIndex == 1 {
        backingModel = builder.buildStandingsModel()
        model = backingModel
      }
      
      else if decodedSegementedIndex == 2 {
        backingGamesModel = builder.buildScheduleModel()
        gamesModel = backingGamesModel
      }
    }
    
    super.decodeRestorableState(with: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    restorationIdentifier = String(describing: StandingsViewController.self) + "RestorationIdentifier"
    //restorationClass = StandingsViewController.self
    
    reloadBackend()
        
    tableView.allowsSelection = false
    tableView.keyboardDismissMode = .interactive
    tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseIdentifier)
    
    // setup search bar
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.hidesNavigationBarDuringPresentation = false
    search.searchResultsUpdater = self
    // search.delegate = self
    search.searchBar.placeholder = "Updating 🏈 exefel..."
    search.searchBar.scopeButtonTitles = ["Divisions", "Standings", "Schedule"]
    search.searchBar.showsScopeBar = true
    search.searchBar.scopeBarBackgroundImage = UIImage.imageWithColor(UIColor.clear)
    search.searchBar.delegate = self
    search.searchBar.showsCancelButton = false
    search.searchBar.selectedScopeButtonIndex = decodedSegementedIndex ?? 0

    //if ![0, 1, 2].contains(search.searchBar.selectedScopeButtonIndex) {
    
//    if let scopeBar = search.searchBar.subviews.first?.subviews.first?.subviews.first(where: { $0 is UISegmentedControl }) as? UISegmentedControl { // lol
//      scopeBar.addTarget(self, action: #selector(scopeBarTapped(_:)), for: .allTouchEvents)
//    }
//
    extendedLayoutIncludesOpaqueBars = true
    definesPresentationContext = true
    navigationItem.titleView = search.searchBar
    search.searchBar.sizeToFit()
    
    searchController = search
    
    self.becomeFirstResponder()
    // search.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bar button more"), style: .plain, target: self, action: #selector(moreBarButtonItemTapped))
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    feedbackGenerator.prepare()
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    guard event?.subtype == UIEvent.EventSubtype.motionShake else {
      return
    }
    
    self.searchController?.searchBar.placeholder = "Updating 🏈 exefel..."
    reloadBackend()
  }
  
  @objc func moreBarButtonItemTapped() {
    let versionString = "v\(Bundle.main.version ?? "??")-\(Bundle.main.build ?? "??") from \(DateFormatter.localizedString(from: Bundle.main.buildDate ?? Date(), dateStyle: .short, timeStyle: .short))"
    let alert = UIAlertController(title: "🏈", message: versionString, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "About", style: .default, handler: { (_) in
      
    }))
    alert.addAction(UIAlertAction(title: "Refresh...", style: .default, handler: { (_) in
      self.searchController?.searchBar.placeholder = "Updating 🏈 exefel..."
      self.reloadBackend()
    }))
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
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
    self.feedbackGenerator.selectionChanged()

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
