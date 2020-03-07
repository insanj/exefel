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
}