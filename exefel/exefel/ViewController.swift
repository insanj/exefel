//
//  ViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  // MARK: - models
  struct Model {
    let title: String?
    let sections: [ModelSection]
  }
  
  struct ModelSection {
    let title: String?
    let footer: String?
    let items: [ModelItem]
  }
  
  struct ModelItem {
    let title: String?
    let subtitle: String?
    let image: UIImage?
    let indicator: UITableViewCell.AccessoryType
    let action: ((ViewController) -> (Void))?
  }
  
  // MARK: - properties
  var model: ViewController.Model? {
    didSet {
      title = model?.title
      tableView.reloadData()
    }
  }
  
  private let REUSE_IDENTIFIER = "REUSE_IDENTIFIER"

  // MARK: - init
  init(model: ViewController.Model?=nil) {
    super.init(style: .insetGrouped)
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
    themeify()
  }
  
  func themeify() {
    // view.backgroundColor = UIColor.secondarySystemBackground
    tableView.reloadData()
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
    return 62.0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
    
    guard let item = model?.sections[indexPath.section].items[indexPath.row] else {
      return cell
    }
    
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.subtitle
    cell.imageView?.image = item.image
    cell.accessoryType = item.indicator
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
