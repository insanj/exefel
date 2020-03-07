//
//  AppDelegate.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var rootViewController: UINavigationController?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let standingsViewController = StandingsViewController() // TODO recreate based on persistent stack?
    window?.rootViewController = UINavigationController(rootViewController: standingsViewController)
    window?.makeKeyAndVisible()
    
    return true
  }

}

