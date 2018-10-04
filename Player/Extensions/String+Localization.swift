//
//  Strings+Localization.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  public func localize(values replace: [Any]) -> String {
    var string = localized
    if string == self {
      return self
    }
    var array = string.components(separatedBy: "%")
    string = ""
    _ = replace.count + 1
    for (index, element) in replace.enumerated() {
      if index < array.count {
        let new = array.remove(at: 0)
        string = index == 0 ? "\(new)\(element)" : "\(string)\(new)\(element) "
      }
    }
    string += array.joined(separator: "")
    string = string.replacingOccurrences(of: "  ", with: " ")
    return string
  }
}
