//
//  LoadViewController.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import Hydra
import JAHud
import JAHudHydra
import LogWrapperKit

class LoadViewController: UIViewController, SegueHandler {
  
  typealias SegueIdentifier = Segue
  
  enum Segue: String {
    case loaded = "Segue.cameras"
    case failed = "Segue.failed"
  }
  
  var cameras: [Camera]?
  var failureReason: LoadFailureReason = .serviceFailed
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Hud.asyncPresentWait(on: self,
                         title: Strings.Load.hudTitle,
                         text: Strings.Load.hudPrompt,
                         presentationStyle: .overCurrentContext)
    .then(in: .userInitiated) { () -> Promise<[Camera]> in
      let service = RestService()
      return service.avaliableCameras()
    }.then(in: .main) { (cameras) in
      guard cameras.count > 0 else {
        self.loadFailed(because: .noCameras)
        return
      }
      self.loadSucceded(cameras: cameras)
    }.catch { (error) in
      log(error: error)
      self.loadFailed()
    }
  }
  
  func loadSucceded(cameras: [Camera]) {
    self.cameras = cameras
    Hud.asyncPresentSuccess(on: self)
    .then(in: .main) { () -> Promise<Void> in
      return Hud.asynDismiss(from: self)
    }.then(in: .main) { ()
      self.performSegue(withIdentifier: .loaded, sender: self)
    }
  }
  
  func loadFailed(because: LoadFailureReason = .serviceFailed) {
    failureReason = because
    Hud.asyncPresentFailure(on: self)
    .then(in: .main) { () -> Promise<Void> in
      return Hud.asynDismiss(from: self)
    }.then(in: .main) { ()
      self.performSegue(withIdentifier: .failed, sender: self)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segueIdentifier(forSegue: segue) == .loaded {
      guard let controller = segue.destination as? PageViewController, let cameras = cameras else {
        return
      }
      log(debug: "Set cameras")
      controller.cameras = cameras
    } else if segueIdentifier(forSegue: segue) == .failed {
      guard let controller = segue.destination as? LoadFailedViewController else {
        return
      }
      controller.failureReason = failureReason
    }
  }
}
