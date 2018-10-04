//
//  UIView+SafeGuides.swift
//  PageViewTest
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    } else {
      return self.topAnchor
    }
  }
  
  var safeLeadingAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leadingAnchor
    }else {
      return self.leadingAnchor
    }
  }
  
  var safeTrailingAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.trailingAnchor
    }else {
      return self.trailingAnchor
    }
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    } else {
      return self.bottomAnchor
    }
  }
}
