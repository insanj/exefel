//
//  SheetsNetworker.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Foundation

class SheetsNetworker {
  fileprivate let API_KEY = "AIzaSyDgoVeaQFQxldPCaTY71ghWgpNiEcI8Z4U"
  fileprivate let SPREADSHEET_ID = "16JTAryXBebyXXZfeNzgLQmEQtZpXruPH37i3AqXDnIk"
  
  func weekOne(_ completion: @escaping () -> (Void)) -> URLSessionTask? {
    let weekOneRange = "Week 1!A1:B9"
    return task(spreadsheetId: SPREADSHEET_ID, range: weekOneRange, completion)
  }
  
  fileprivate func buildTaskURL(spreadsheetId: String, range: String) -> URL? {
    return URL(string: "https://sheets.googleapis.com/v4/spreadsheets/\(spreadsheetId)/values/\(range)?key=\(API_KEY)")
  }
  
  fileprivate func task(spreadsheetId: String, range: String, _ completion: @escaping () -> (Void)) -> URLSessionTask? {
    guard let url = buildTaskURL(spreadsheetId: spreadsheetId, range: range) else {
      completion()
      return nil
    }
    
    let req = URLRequest(url: url)
    let session = URLSession.shared
    let task = session.dataTask(with: req) { (data, response, error) in
      guard response?.mimeType == "application/json" else {
        completion()
        return
      }
      
      guard let d = data else {
        completion()
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: d, options: [])
        guard let jsonDict = json as? [String: Any] else {
          completion()
          return
        }
          
        completion()
      } catch let jsonError {
        completion()
      }
    }
    
    return task
  }
}
