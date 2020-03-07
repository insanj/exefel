//
//  StandingsViewController.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class StandingsViewController: ViewController {
  
  static func buildModel() -> ViewController.Model {
    
    let xflEast = ViewController.ModelSection(title: "XFL East", footer: nil, items: {
      let battlehawks = ViewController.ModelItem(title: "Battlehawks", subtitle: "St. Louis", image: UIImage(named: "STL")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let defenders = ViewController.ModelItem(title: "Defenders", subtitle: "DC", image: UIImage(named: "DC")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let guardians = ViewController.ModelItem(title: "Guardians", subtitle: "New York", image: UIImage(named: "NY")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let vipers = ViewController.ModelItem(title: "Vipers", subtitle: "Tampa Bay", image: UIImage(named: "TB")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      return [battlehawks, defenders, guardians, vipers]
    }())
    
    let xflWest = ViewController.ModelSection(title: "XFL West", footer: "Thanks for using exefel!\nv\(Bundle.main.version ?? "??")-\(Bundle.main.build ?? "??") from \(DateFormatter.localizedString(from: Bundle.main.buildDate ?? Date(), dateStyle: .short, timeStyle: .short))", items: {
      let roughnecks = ViewController.ModelItem(title: "Roughnecks", subtitle: "Houston", image: UIImage(named: "HOU")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let renegades = ViewController.ModelItem(title: "Renegades", subtitle: "Dallas", image: UIImage(named: "DAL")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let wildcats = ViewController.ModelItem(title: "Wildcats", subtitle: "LA", image: UIImage(named: "LA")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      let dragons = ViewController.ModelItem(title: "Dragons", subtitle: "Seattle", image: UIImage(named: "SEA")?.resize(newWidth: 50.0), indicator: .disclosureIndicator, action: nil)
      return [dragons, renegades, roughnecks, wildcats]
    }())
    
    return ViewController.Model(title: "Teams", sections: [xflEast, xflWest])
  }
  
  override init(model: ViewController.Model?=StandingsViewController.buildModel()) {
    super.init(model: model)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func reloadBackend() {
    
    let scraper = Scraper()
    scraper.get() { result in
      print(result)
      // self.model = ViewController.Model(result: result)
    }
  }
}
