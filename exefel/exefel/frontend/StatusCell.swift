//
//  StatusCell.swift
//  exefel
//
//  Created by julian on 3/12/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class StatusCell: UICollectionViewCell {
  static let reuseIdentifier = "StatusCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(frame: .zero)
    setup()
  }
  
  func setup() {
    themeify()
  }
  
  func themeify() {
    
  }
  
  
}
