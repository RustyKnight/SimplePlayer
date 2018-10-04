//
//  UIApplication+CurrentViewController.swift
//  CleanSweep
//
//  Created by Shane Whitehead on 5/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
	
	var topViewController: UIViewController? {
		guard var topController = UIApplication.shared.keyWindow?.rootViewController else {
			return nil
		}
		while let presentedViewController = topController.presentedViewController {
			topController = presentedViewController
		}
		
		return topController
	}
	
}
