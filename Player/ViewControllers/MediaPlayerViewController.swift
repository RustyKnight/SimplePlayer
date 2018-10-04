//
//  ViewController.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit
import LogWrapperKit

protocol MediaPlayerDelegate {
  func mediPlayerWasTapped(_ mediaPlayer: MediaPlayerViewController)
}

class MediaPlayerViewController: UIViewController {

  @IBOutlet weak var movieView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var camera: Camera?
  var vlcMediaPlayer: VLCMediaPlayer!
  
  var delegate: MediaPlayerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    vlcMediaPlayer = VLCMediaPlayer()
    vlcMediaPlayer.delegate = self
    vlcMediaPlayer.drawable = movieView
    
    guard let camera = camera else {
      return
    }

    vlcMediaPlayer.media = VLCMedia(url: camera.url)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    activityIndicator.startAnimating()
    play()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    pause()
  }
  
  var touchedAt: Date?
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    touchedAt = Date()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard let touchedAt = touchedAt else {
      return
    }
    let time = Date().timeIntervalSince(touchedAt)
    guard time < 0.25 else {
      return
    }
    delegate?.mediPlayerWasTapped(self)
  }
  
  func play() {
    vlcMediaPlayer.play()
  }
  
  func pause() {
    vlcMediaPlayer.pause()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

extension MediaPlayerViewController: VLCMediaPlayerDelegate {
  
  func mediaPlayerTimeChanged(_ aNotification: Notification!) {
    activityIndicator.stopAnimating()
  }
  
  func mediaPlayerStateChanged(_ aNotification: Notification!) {
  }
}

extension VLCMediaPlayerState: CustomStringConvertible {
  public var description: String {
    switch self {
    case .stopped: return "Stopped"
    case .opening: return "Opening"
    case .buffering: return "Buffering"
    case .ended: return "Ended"
    case .error: return "Error"
    case .playing: return "Playing"
    case .paused: return "Paused"
    case .esAdded: return "ESAdded"
    }
  }
}
