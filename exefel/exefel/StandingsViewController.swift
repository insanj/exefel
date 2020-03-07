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
    
    let xflEast = ViewController.ModelSection(title: "XFL East", items: {
      let battlehawks = ViewController.ModelItem(title: "Battlehawks", subtitle: "St. Louis", image: UIImage(named: "STL")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let defenders = ViewController.ModelItem(title: "Defenders", subtitle: "DC", image: UIImage(named: "DC")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let guardians = ViewController.ModelItem(title: "Guardians", subtitle: "New York", image: UIImage(named: "NY")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let vipers = ViewController.ModelItem(title: "Vipers", subtitle: "Tampa Bay", image: UIImage(named: "TB")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      return [battlehawks, defenders, guardians, vipers]
    }())
    
    let xflWest = ViewController.ModelSection(title: "XFL West", items: {
      let roughnecks = ViewController.ModelItem(title: "Roughnecks", subtitle: "Houston", image: UIImage(named: "HOU")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let renegades = ViewController.ModelItem(title: "Renegades", subtitle: "Dallas", image: UIImage(named: "DAL")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let wildcats = ViewController.ModelItem(title: "Wildcats", subtitle: "LA", image: UIImage(named: "LA")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      let dragons = ViewController.ModelItem(title: "Dragons", subtitle: "Seattle", image: UIImage(named: "SEA")?.resize(newHeight: 50.0), indicator: .disclosureIndicator, action: nil)
      return [dragons, renegades, roughnecks, wildcats]
    }())
    
    return ViewController.Model(title: "Standings", sections: [xflEast, xflWest])
  }
  
  override init(model: ViewController.Model?=StandingsViewController.buildModel()) {
    super.init(model: model)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
