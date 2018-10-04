//
//  Strings.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation

struct Strings {

  struct General {
    static let ok = "General.text.ok".localized
    static let cancel = "General.text.cancel".localized
    static let yes = "General.text.yes".localized
    static let no = "General.text.no".localized
  }
  
  struct Load {
    static let hudTitle = "Load.hud.title".localized
    static let hudPrompt = "Load.hud.prompt".localized
  }
  
  struct Failed {
    static let serviceFailed = "Failed.text.serviceFailed".localized
    static let noCameras = "Failed.text.noCameras".localized
  }
}
