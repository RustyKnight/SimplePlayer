//
//  LoadFailedViewController.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit

enum LoadFailureReason {
  case serviceFailed
  case noCameras
}

class LoadFailedViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var failedLabel: UILabel!
  
  var failureReason: LoadFailureReason = .serviceFailed
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.image = Player.imageOfFailed(imageSize: CGSize(width: 100, height: 100))
    switch failureReason {
    case .serviceFailed: failedLabel.text = Strings.Failed.serviceFailed
    case .noCameras: failedLabel.text = Strings.Failed.noCameras
    }
    
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
}
