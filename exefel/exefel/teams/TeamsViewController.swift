//
//  TeamsViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class TeamsViewController: UITableViewController {
  // MARK: - models
  struct Model {
    let title: String?
    let sections: [ModelSection]
    
    init(title: String?, sections: [ModelSection]) {
      self.title = title
      self.sections = sections
    }
//
//    init(title: String?, result: Scraper.Result?) {
//      self.title = title
//
//      if let r = result {
//        self.sections = result?.games.
//      } else {
//        self.sections = [ModelSection]()
//      }
//    }
  }
  
  struct ModelSection {
    let title: String?
    let footer: String?
    let items: [ModelItem]
  }
  
  struct ModelItem {
    //let title: String?
    //let subtitle: String?
    //let image: UIImage?
    let cell: TeamCell.Model
    let indicator: UITableViewCell.AccessoryType
    let action: ((TeamsViewController) -> (Void))?
  }
  
  // MARK: - properties
  var model: TeamsViewController.Model? {
    didSet {
      title = model?.title
      tableView.reloadData()
    }
  }
  
  private let REUSE_IDENTIFIER = "REUSE_IDENTIFIER"

  // MARK: - init
  init(model: TeamsViewController.Model?=nil) {
    super.init(style: .grouped)
    self.model = model
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - view lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = model?.title
    
    tableView.register(TeamCell.self, forCellReuseIdentifier: REUSE_IDENTIFIER)
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
    reloadRefreshControl(refresh)
    tableView.refreshControl = refresh
    
    reloadBackend()
    themeify()
  }
  
  func themeify() {
    // view.backgroundColor = UIColor.secondarySystemBackground
    tableView.reloadData()
  }
  
  func reloadBackend() {
    // no - op
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    tableView.reloadData()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animate(alongsideTransition: { (context) in
      self.tableView.reloadData()
    }, completion: nil)
    
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  // MARK: - ux / actions
  fileprivate var refreshControlShouldEnd = false
  @objc func refreshControlValueChanged(_ refresh: UIRefreshControl) {
    refreshControlShouldEnd = true
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    // super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    
    if let refresh = refreshControl, refreshControlShouldEnd {
      reloadBackend()
      refresh.endRefreshing()
      reloadRefreshControl(refresh)
    }
  }
  
  func reloadRefreshControl(_ refresh: UIRefreshControl) {
    refresh.attributedTitle = NSAttributedString(string: "Last Updated \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))", attributes: [.foregroundColor: UIColor.secondaryLabel, .font: UIFont.preferredFont(forTextStyle: .footnote)])
  }
  
  // MARK: - table view
  // MARK: data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return model?.sections.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return model?.sections[section].title
  }
  
  override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return model?.sections[section].footer
  }
  
  override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    guard let footer = view as? UITableViewHeaderFooterView else {
      return
    }
        
    footer.textLabel?.textAlignment = .center
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sectionModel = model?.sections[section] else {
      return 0
    }
    
    return sectionModel.items.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return TeamCell.height
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
    
    guard let item = model?.sections[indexPath.section].items[indexPath.row] else {
      return cell
    }
    
//    cell.textLabel?.text = item.title
//    cell.detailTextLabel?.text = item.subtitle
//    cell.imageView?.image = item.image
    cell.accessoryType = item.indicator

    guard let teamCell = cell as? TeamCell else {
      return cell
    }
    
    teamCell.model = item.cell
    return cell
  }
  
  // MARK: delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let action = model?.sections[indexPath.section].items[indexPath.row].action else {
      return
    }
    
    action(self)
  }
}
