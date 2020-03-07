//
//  Bundle+Extension.swift
//  Submarine
//
//  Created by julian on 8/4/19.
//  Copyright © 2019 Julian Weiss. All rights reserved.
//

import Foundation

extension Bundle {
  var build: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
  }
  
  var version: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  var buildDate: Date? {
    if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
      let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
      let infoDate = infoAttr[.modificationDate] as? Date {
      return infoDate
    }
    
    return nil
  }
}
