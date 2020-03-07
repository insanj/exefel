//
//  String+Extension.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

extension String {
  // https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
  func matches(for regex: String) -> [String] {
      do {
          let regex = try NSRegularExpression(pattern: regex)
          let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
          return results.compactMap {
            Range($0.range, in: self).map { String(self[$0]) }
          }
      } catch let error {
          print("invalid regex: \(error.localizedDescription)")
          return []
      }
  }
  
  func matches(for regex: String, group: Int) -> [String] {
      do {
          let regex = try NSRegularExpression(pattern: regex)
          let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
          return results.compactMap {
            Range($0.range(at: group), in: self).map { String(self[$0]) }
          }
      } catch let error {
          print("invalid regex: \(error.localizedDescription)")
          return []
      }
  }
}
