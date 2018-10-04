//
//  PageViewController.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import LogWrapperKit
import Hydra

class PageViewController: UIPageViewController, SegueHandler {
  
  typealias SegueIdentifier = Segue
  
  enum Segue: String {
    case settings = "Segue.settings"
    case fromSettings = "Segue.fromSettings"
  }
  
  var cameras: [Camera] = []
  
  var orderedViewControllers: [UIViewController] = []
  
  var pageControl: UIPageControl = UIPageControl()
  var settingsButton: UIButton = UIButton()
  
  var controlsAreHidden: Bool = false
  
  var currentAnimation: UIViewPropertyAnimator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for camera in cameras {
      guard let mpController = viewController(withStoryboardIdentifier: "MediaPlayer") as? MediaPlayerViewController else {
        fatalError("Could not load [MediaPlayer] view controller from Storyboard")
      }
      mpController.camera = camera
      mpController.delegate = self
      orderedViewControllers.append(mpController)
    }

    dataSource = self
    delegate = self
    
    configureControls()
    
    guard let firstViewController = orderedViewControllers.first else {
      return
    }
    setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    
    controlsToFront()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    hideControls()
  }
  
  // MARK: - Animation controls
  
  func updateControlsState() {
    if controlsAreHidden {
      showControls()
    } else {
      hideControls()
    }
  }
  
  func makeAnimation(_ animation: @escaping () -> Void) {
    
    var duration = 1.0
    currentAnimation?.stopAnimation(true)
    if let animation = currentAnimation {
      log(debug: "\(animation.fractionComplete)")
      duration *= Double(animation.fractionComplete)
    }
    
    currentAnimation = UIViewPropertyAnimator(duration: duration, curve: UIView.AnimationCurve.easeInOut, animations: animation)
    currentAnimation?.addCompletion({ (position) in
      self.currentAnimation = nil
    })
    currentAnimation?.startAnimation()
  }
  
  func hideControls() {
    controlsAreHidden = true
    makeAnimation {
      self.pageControl.alpha = 0
      self.settingsButton.alpha = 0
    }
  }
  
  func showControls() {
    controlsAreHidden = false
    
    makeAnimation {
      self.pageControl.alpha = 1
      self.settingsButton.alpha = 1
    }
  }
  
  // MARK: - Control management
  
  func controlsToFront() {
    view.bringSubviewToFront(pageControl)
    view.bringSubviewToFront(settingsButton)
  }
  
  func configureControls() {
    configureSettingsButton()
    configurePageControl()
  }
  
  func configureSettingsButton() {
    let image = Player.imageOfSettings(imageSize: CGSize(width: 50, height: 50))
    settingsButton.setImage(image, for: [])
    settingsButton.setTitle(nil, for: [])
    settingsButton.translatesAutoresizingMaskIntoConstraints = false
    settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)
    view.addSubview(settingsButton)

    NSLayoutConstraint.activate([
      view.safeTrailingAnchor.constraint(equalTo: settingsButton.trailingAnchor, constant: 8),
      view.safeTopAnchor.constraint(equalTo: settingsButton.topAnchor, constant: -8)
      ])
  }
  
  func configurePageControl() {
    pageControl.numberOfPages = orderedViewControllers.count
    pageControl.currentPage = 0
    pageControl.tintColor = UIColor.black
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.green
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(pageControl)
    
    NSLayoutConstraint.activate([
      view.safeBottomAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
      view.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor, constant: 1.0)
      ])
  }
  
  @objc func showSettings() {
    performSegue(withIdentifier: Segue.settings, sender: self)
  }
  
  @IBAction func unwindFromSetting(segue: UIStoryboardSegue) {
    
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
  
  enum Direction {
    case after
    case before
  }
  
  func viewController(withStoryboardIdentifier identifer: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifer)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, nextViewController direction: Direction, viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    let delta = direction == .after ? 1 : -1
    let nextIndex = viewControllerIndex + delta
    let count = orderedViewControllers.count
    
    guard 0..<count ~= nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return self.pageViewController(pageViewController, nextViewController: .before, viewController: viewController)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return self.pageViewController(pageViewController, nextViewController: .after, viewController: viewController)
  }
  
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let pageContentViewController = pageViewController.viewControllers![0]
    let page = orderedViewControllers.index(of: pageContentViewController)!
    print(page)
    pageControl.currentPage = page
    controlsToFront()
    
    after(1.0).then {
      self.hideControls()
    }
  }
  
}

// MARK: - MediaPlayerDelegate

extension PageViewController: MediaPlayerDelegate {
  
  func mediPlayerWasTapped(_ mediaPlayer: MediaPlayerViewController) {
    updateControlsState()
  }
  
  
}

