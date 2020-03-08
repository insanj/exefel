//
//  TeamCell.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
  // MARK: - static vars
  static let height: CGFloat = 92.0
  static let reuseIdentifier: String = "TeamCell"
  
  // MARK: fonts
  static var topFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .footnote)
  }
  
  static var middleFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .title1)
  }
  
  static var bottomFont: UIFont {
    return UIFont.preferredFont(forTextStyle: .footnote)
  }
  
  // MARK: colors
  static var backgroundColor: UIColor {
    return UIColor.systemBackground
  }
  
  static var topColor: UIColor {
    return UIColor.label
  }
  
  static var middleColor: UIColor {
    return UIColor.label
  }
  
  static var bottomColor: UIColor {
    return UIColor.secondaryLabel
  }
  
  // MARK: - Model
  struct Model {
    let image: UIImage?
    let top: String?
    let middle: String?
    let bottom: String?
  }
  
  var model: TeamCell.Model? {
    didSet {
      leftImageView.image = model?.image
      topLabel.text = model?.top
      middleLabel.text = model?.middle
      bottomLabel.text = model?.bottom
    }
  }
  
  // MARK: - fileprivate views
  fileprivate let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let leftImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let topLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let middleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate let bottomLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
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

    containerView.addSubview(leftImageView)
    leftImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    leftImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0).isActive = true
    leftImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10.0).isActive = true
    leftImageView.widthAnchor.constraint(equalTo: leftImageView.heightAnchor).isActive = true

    containerView.addSubview(middleLabel)
    middleLabel.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 18.0).isActive = true
    middleLabel.centerYAnchor.constraint(equalTo: leftImageView.centerYAnchor).isActive = true
    middleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    
    containerView.addSubview(topLabel)
    topLabel.leftAnchor.constraint(equalTo: middleLabel.leftAnchor).isActive = true
    topLabel.bottomAnchor.constraint(equalTo: middleLabel.topAnchor).isActive = true
    topLabel.rightAnchor.constraint(equalTo: middleLabel.rightAnchor).isActive = true

    containerView.addSubview(bottomLabel)
    bottomLabel.leftAnchor.constraint(equalTo: middleLabel.leftAnchor).isActive = true
    bottomLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor).isActive = true
    bottomLabel.rightAnchor.constraint(equalTo: middleLabel.rightAnchor).isActive = true

    themeify()
  }
  
  func themeify() {
    backgroundColor = TeamCell.backgroundColor
    
    topLabel.font = TeamCell.topFont
    middleLabel.font = TeamCell.middleFont
    bottomLabel.font = TeamCell.bottomFont
    
    topLabel.textColor = TeamCell.topColor
    middleLabel.textColor = TeamCell.middleColor
    bottomLabel.textColor = TeamCell.bottomColor
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    model = nil
  }
}
