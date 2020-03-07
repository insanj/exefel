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
      let battlehawks = ViewController.ModelItem(title: "Battlehawks", subtitle: "St. Louis", image: nil, indicator: .disclosureIndicator, action: nil)
      let defenders = ViewController.ModelItem(title: "Defenders", subtitle: "DC", image: nil, indicator: .disclosureIndicator, action: nil)
      let guardians = ViewController.ModelItem(title: "Guardians", subtitle: "New York", image: nil, indicator: .disclosureIndicator, action: nil)
      let vipers = ViewController.ModelItem(title: "Vipers", subtitle: "Tampa Bay", image: nil, indicator: .disclosureIndicator, action: nil)
      return [battlehawks, defenders, guardians, vipers]
    }())
    
    
    let xflWest = ViewController.ModelSection(title: "XFL West", items: {
      let roughnecks = ViewController.ModelItem(title: "Roughnecks", subtitle: "Houston", image: nil, indicator: .disclosureIndicator, action: nil)
      let renegades = ViewController.ModelItem(title: "Renegades", subtitle: "Dallas", image: nil, indicator: .disclosureIndicator, action: nil)
      let wildcats = ViewController.ModelItem(title: "Wildcats", subtitle: "LA", image: nil, indicator: .disclosureIndicator, action: nil)
      let dragons = ViewController.ModelItem(title: "Dragons", subtitle: "Seattle", image: nil, indicator: .disclosureIndicator, action: nil)

      return [roughnecks, renegades, wildcats, dragons]
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
