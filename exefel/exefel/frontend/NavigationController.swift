//
//  NavigationController.swift
//  exefel
//
//  Created by julian on 3/8/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
//  static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
//    return NavigationController(coder: coder)
//  }
//
  let standingsViewController: StandingsViewController
  
  static let restorationIdentifier = String(describing: NavigationController.self) + "RestorationIdentifier"
  
  init() {
    self.standingsViewController = StandingsViewController()
    super.init(rootViewController: standingsViewController)
  }
  
  required init?(coder: NSCoder) {
    self.standingsViewController = StandingsViewController(coder: coder) ?? StandingsViewController()
    super.init(rootViewController: standingsViewController)
  }
  
  
//  static var tintColor: UIColor {
//    return UIColor(red: 1.000, green: 0.716, blue: 0.469, alpha: 1.00)
//  }
//
  override func viewDidLoad() {
    super.viewDidLoad()

    restorationIdentifier = NavigationController.restorationIdentifier
    //restorationClass = NavigationController.self
    
    //themeify()
  }
//
//  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//    super.traitCollectionDidChange(previousTraitCollection)
//    themeify()
//  }
//
//  func themeify() {
//    navigationBar.barTintColor = NavigationController.tintColor
//  }
//
}
