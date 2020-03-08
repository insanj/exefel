//
//  NavigationController.swift
//  exefel
//
//  Created by julian on 3/8/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  static var tintColor: UIColor {
    return UIColor(red: 1.000, green: 0.716, blue: 0.469, alpha: 1.00)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    themeify()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    themeify()
  }
  
  func themeify() {
    navigationBar.barTintColor = NavigationController.tintColor
  }
  
}
