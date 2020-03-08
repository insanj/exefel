//
//  UIImage+Extension.swift
//  exefel
//
//  Created by julian on 3/7/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import UIKit

extension UIImage {
  func resize(newHeight: CGFloat) -> UIImage? {
    let scale = newHeight / self.size.height
    let newWidth = self.size.width * scale
    let newSize = CGSize(width: newWidth, height: newHeight)
    let newRect = CGRect(origin: .zero, size: newSize)
    
    UIGraphicsBeginImageContext(newSize)
    self.draw(in: newRect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  func resize(newWidth: CGFloat) -> UIImage? {
    let scale = newWidth / self.size.width
    let newHeight = self.size.height * scale
    let newSize = CGSize(width: newWidth, height: newHeight)
    let newRect = CGRect(origin: .zero, size: newSize)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
    self.draw(in: newRect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  class func imageWithColor(_ color: UIColor) -> UIImage? {
    let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, UIScreen.main.scale)
    color.setFill()
    UIRectFill(rect)
    guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
      return nil
    }
    UIGraphicsEndImageContext()
    return image
  }
}
