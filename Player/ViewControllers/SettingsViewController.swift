//
//  SettingsViewController.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var settingsImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backButton.setImage(Player.imageOfBack(imageSize: CGSize(width: 44, height: 44)), for: [])
    backButton.setTitle(nil, for: [])
    
    settingsImageView.image = Player.imageOfSettings(imageSize: CGSize(width: 200, height: 200), fill: UIColor.black)
  }
  
}
