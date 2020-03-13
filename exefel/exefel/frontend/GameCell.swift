//
//  GameCell.swift
//  exefel
//
//  Created by julian on 3/8/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
  // MARK: - static vars
  static let height: CGFloat = 76.0
  static let reuseIdentifier: String = "GameCell"
  
  // MARK: fonts
  static var leftFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .body)
  }
  
  static var rightFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .subheadline)
  }

  static var leftBoldFont: UIFont {
    return UIFont.systemFont(ofSize: leftFont.pointSize, weight: .bold)
  }
  
  static var rightBoldFont: UIFont {
    return UIFont.systemFont(ofSize: rightFont.pointSize, weight: .bold)
  }
  
  // MARK: colors
  static var backgroundColor: UIColor {
    return UIColor.secondarySystemBackground
  }
  
  static var leftColor: UIColor {
    return UIColor.label
  }
  
  static var rightTopColor: UIColor {
    return UIColor.secondaryLabel
  }
  
  static var rightBottomColor: UIColor {
    return UIColor.tertiaryLabel
  }
  
  // MARK: - Model
//  struct Model {
//    let underlying: Scraper.ResultGame?
//    let leftTop: ModelSide?
//    let leftBottom: ModelSide?
//    let rightTop: String?
//    let rightBottom: String?
//
//    init(underlying: Scraper.ResultGame?=nil,
//         leftTop: ModelSide?=nil,
//         leftBottom: ModelSide?=nil,
//         rightTop: String?=nil,
//         rightBottom: String?=nil) {
//      self.underlying = underlying
//      self.leftTop = leftTop
//      self.leftBottom = leftBottom
//      self.rightTop = rightTop
//      self.rightBottom = rightBottom
//    }
//  }
//
//  struct ModelSide {
//    let image: UIImage?
//    let title: String?
//  }
  
  struct Model {
    let underlying: Scraper.ResultGame
    let top: ModelSide?
    let bottom: ModelSide?
  }
  
  struct ModelSide {
    let image: UIImage?
    let left: String?
    let middle: String?
    let right: String?
    let shouldBeBold: Bool

    init(image: UIImage?=nil, left: String?=nil, middle: String?=nil, right: String?=nil, shouldBeBold: Bool=false) {
      self.image = image
      self.left = left
      self.middle = middle
      self.right = right
      self.shouldBeBold = shouldBeBold
    }
  }
  
  var model: GameCell.Model? {
    didSet {
      topLeftImageView.image = model?.top?.image
      topLeftLabel.text = model?.top?.left
      topMiddleLabel.text = model?.top?.middle
      topRightLabel.text = model?.top?.right
      
      bottomLeftImageView.image = model?.bottom?.image
      bottomLeftLabel.text = model?.bottom?.left
      bottomMiddleLabel.text = model?.bottom?.middle
      bottomRightLabel.text = model?.bottom?.right
      
      if model?.top?.shouldBeBold == true {
        topLeftLabel.font = GameCell.leftBoldFont
        topMiddleLabel.font = GameCell.rightBoldFont
      } else {
        topLeftLabel.font = GameCell.leftFont
        topMiddleLabel.font = GameCell.rightFont
      }
      
      if model?.bottom?.shouldBeBold == true {
        bottomLeftLabel.font = GameCell.leftBoldFont
        bottomMiddleLabel.font = GameCell.rightBoldFont
      } else {
        bottomLeftLabel.font = GameCell.leftFont
        bottomMiddleLabel.font = GameCell.rightFont
      }
    }
  }
  
  // MARK: - fileprivate views
  fileprivate let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let topLeftImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let topLeftLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let topMiddleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let topRightLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let bottomLeftImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let bottomLeftLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let bottomMiddleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let bottomRightLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(style: .value1, reuseIdentifier: TeamCell.reuseIdentifier)
    setup()
  }
  
  static var rightLabelWidth: CGFloat {
    return 76.0 // go 76ers! 🏀
  }
  
  func setup() {
    layoutMargins = .zero

    contentView.addSubview(containerView)
    containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12.0).isActive = true
    containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true

    containerView.addSubview(topLeftImageView)
    topLeftImageView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -1).isActive = true
    topLeftImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    topLeftImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0).isActive = true
    topLeftImageView.widthAnchor.constraint(equalTo: topLeftImageView.heightAnchor).isActive = true
    
    containerView.addSubview(topRightLabel)
    topRightLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -6.0).isActive = true
    topRightLabel.centerYAnchor.constraint(equalTo: topLeftImageView.centerYAnchor).isActive = true
    topRightLabel.widthAnchor.constraint(equalToConstant: GameCell.rightLabelWidth).isActive = true

    containerView.addSubview(topMiddleLabel)
    topMiddleLabel.rightAnchor.constraint(equalTo: topRightLabel.leftAnchor, constant: -4.0).isActive = true
    topMiddleLabel.centerYAnchor.constraint(equalTo: topLeftImageView.centerYAnchor).isActive = true
    
    containerView.addSubview(topLeftLabel)
    topLeftLabel.leftAnchor.constraint(equalTo: topLeftImageView.rightAnchor, constant: 6.0).isActive = true
    topLeftLabel.centerYAnchor.constraint(equalTo: topLeftImageView.centerYAnchor).isActive = true
    topLeftLabel.rightAnchor.constraint(lessThanOrEqualTo: topMiddleLabel.leftAnchor, constant: -3).isActive = true
        
    containerView.addSubview(bottomLeftImageView)
    bottomLeftImageView.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 1).isActive = true
    bottomLeftImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    bottomLeftImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0).isActive = true
    bottomLeftImageView.widthAnchor.constraint(equalTo: topLeftImageView.heightAnchor).isActive = true
    
    containerView.addSubview(bottomRightLabel)
    bottomRightLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -6.0).isActive = true
    bottomRightLabel.centerYAnchor.constraint(equalTo: bottomLeftImageView.centerYAnchor).isActive = true
    bottomRightLabel.widthAnchor.constraint(equalToConstant: GameCell.rightLabelWidth).isActive = true

    containerView.addSubview(bottomMiddleLabel)
    bottomMiddleLabel.rightAnchor.constraint(equalTo: bottomRightLabel.leftAnchor, constant: -4.0).isActive = true
    bottomMiddleLabel.centerYAnchor.constraint(equalTo: bottomLeftImageView.centerYAnchor).isActive = true
    
    containerView.addSubview(bottomLeftLabel)
    bottomLeftLabel.leftAnchor.constraint(equalTo: bottomLeftImageView.rightAnchor, constant: 6.0).isActive = true
    bottomLeftLabel.centerYAnchor.constraint(equalTo: bottomLeftImageView.centerYAnchor).isActive = true
    bottomLeftLabel.rightAnchor.constraint(lessThanOrEqualTo: bottomMiddleLabel.leftAnchor, constant: -3).isActive = true
    
    themeify()
  }
  
  func themeify() {
    backgroundColor = GameCell.backgroundColor
    
    topLeftLabel.textColor = GameCell.leftColor
    topMiddleLabel.textColor = GameCell.leftColor
    bottomLeftLabel.textColor = GameCell.leftColor
    bottomMiddleLabel.textColor = GameCell.leftColor
    
    topRightLabel.textColor = GameCell.leftColor
    bottomRightLabel.textColor = GameCell.rightTopColor

    topRightLabel.font = GameCell.rightFont
    bottomRightLabel.font = GameCell.rightFont
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    model = nil
  }
}

extension GameCell.Model: Searchable {
  func matches(text: String) -> Bool {
    let bodyOfTextToSearch = "\(top?.left ?? "") \(top?.middle ?? "") \(top?.right ?? "" ) \(bottom?.left ?? "") \(bottom?.middle ?? "") \(bottom?.right ?? "")"
    let lowercasedBodyOfText = bodyOfTextToSearch.lowercased()
    let lowercasedSearchText = text.lowercased()
    let lowercasedSearchTextComponent = lowercasedSearchText.components(separatedBy: " ")
    for component in lowercasedSearchTextComponent {
      if lowercasedBodyOfText.contains(component) {
        return true
      }
    }
     
    return false
  }
}
