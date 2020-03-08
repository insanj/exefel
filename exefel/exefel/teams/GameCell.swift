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
  static let height: CGFloat = 92.0
  static let reuseIdentifier: String = "GameCell"
  
  // MARK: fonts
  static var leftFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .body)
  }
  
  static var rightFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .body)
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
  struct Model {
    let leftTop: ModelSide?
    let leftBottom: ModelSide?
    let rightTop: String?
    let rightBottom: String?
  }
  
  struct ModelSide {
    let image: UIImage?
    let title: String?
  }
  
  var model: GameCell.Model? {
    didSet {
      leftTopImageView.image = model?.leftTop?.image
      leftTopLabel.text = model?.leftTop?.title
      leftBottomImageView.image = model?.leftBottom?.image
      leftBottomLabel.text = model?.leftBottom?.title
      rightTopLabel.text = model?.rightTop
      rightBottomLabel.text = model?.rightBottom
    }
  }
  
  // MARK: - fileprivate views
  fileprivate let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let leftTopImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let leftBottomImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let leftTopLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let leftBottomLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let rightTopLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let rightBottomLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
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
  
  func setup() {
    contentView.addSubview(containerView)
    containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0).isActive = true
    containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0).isActive = true
    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0).isActive = true
    containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24.0).isActive = true

    containerView.addSubview(leftTopImageView)
    leftTopImageView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    leftTopImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    leftTopImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    leftTopImageView.widthAnchor.constraint(equalTo: leftTopImageView.heightAnchor).isActive = true

    containerView.addSubview(leftBottomImageView)
    leftBottomImageView.topAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    leftBottomImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    leftBottomImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    leftBottomImageView.widthAnchor.constraint(equalTo: leftBottomImageView.heightAnchor).isActive = true

    containerView.addSubview(leftTopLabel)
    leftTopLabel.leftAnchor.constraint(equalTo: leftTopImageView.rightAnchor, constant: 6.0).isActive = true
    leftTopLabel.centerYAnchor.constraint(equalTo: leftTopImageView.centerYAnchor).isActive = true
    leftTopLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -30.0).isActive = true
    
    containerView.addSubview(leftBottomLabel)
    leftBottomLabel.leftAnchor.constraint(equalTo: leftBottomImageView.rightAnchor, constant: 6.0).isActive = true
    leftBottomLabel.centerYAnchor.constraint(equalTo: leftBottomImageView.centerYAnchor).isActive = true
    leftBottomLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -30.0).isActive = true
    
    containerView.addSubview(rightTopLabel)
    rightTopLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    rightTopLabel.bottomAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    rightTopLabel.leftAnchor.constraint(equalTo: leftTopLabel.rightAnchor).isActive = true
    
    containerView.addSubview(rightBottomLabel)
    rightBottomLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    rightBottomLabel.topAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    rightBottomLabel.leftAnchor.constraint(equalTo: leftBottomLabel.rightAnchor).isActive = true
    
    themeify()
  }
  
  func themeify() {
    backgroundColor = GameCell.backgroundColor
    
    leftTopLabel.font = GameCell.leftFont
    leftBottomLabel.font = GameCell.leftFont
    rightTopLabel.font = GameCell.rightFont
    rightBottomLabel.font = GameCell.rightFont
    
    leftTopLabel.textColor = GameCell.leftColor
    leftBottomLabel.textColor = GameCell.leftColor
    rightTopLabel.textColor = GameCell.rightTopColor
    rightBottomLabel.textColor = GameCell.rightBottomColor
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    model = nil
  }
}
