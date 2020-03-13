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
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    return true
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if rootViewController == nil { // if unable to restore, make a new one
      rootViewController = NavigationController()
    }
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    return true
  }
  
  func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
    let identifier = identifierComponents.last
    
    if identifier == NavigationController.restorationIdentifier {
      rootViewController = NavigationController(coder: coder)
      return rootViewController
    }
    
    else if identifier == StandingsViewController.restorationIdentifier {
      let standingsViewController = StandingsViewController(coder: coder)
      return standingsViewController
    }
    
    return nil
  }

  func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
    coder.encode(rootViewController, forKey: "root") // trigger encoding, we don't actually need this "encoded"
  }
  
  static let stateRestorationVersionKey = "exefelVersion"
  static var stateRestorationVersionValue: String {
    return "\(Bundle.main.version ?? "?")-\(Bundle.main.build ?? "?")"
  }
  
  static func shouldRestore(_ coder: NSCoder) -> Bool {
    guard let version = coder.decodeObject(forKey: AppDelegate.stateRestorationVersionKey) as? String, version == AppDelegate.stateRestorationVersionValue else {
      return false
    }
    
    return true
  }

  func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
    coder.encode(AppDelegate.stateRestorationVersionValue, forKey: AppDelegate.stateRestorationVersionKey)
    return true
  }
  
  func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
    coder.encode(AppDelegate.stateRestorationVersionValue, forKey: AppDelegate.stateRestorationVersionKey)
    return true
  }
      
  func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
    return AppDelegate.shouldRestore(coder)
  }

  func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
    return AppDelegate.shouldRestore(coder)
  }
  
  func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
    // print("")
  }
}

/* As always, testing State Restoration goes like this:

 1. Run using Xcode
 2. Press Home Button, encodeRestorableStateWithCoder should be called
 3. Stop using Xcode
 4. Press Home Button for App Switcher and Force Quit the app
 5. Run using Xcode

 */
