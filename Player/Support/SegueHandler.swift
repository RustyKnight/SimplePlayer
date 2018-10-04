//
//  SegueHandler.swift
//  CleanSweep
//
//  Created by Shane Whitehead on 2/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit

protocol SegueHandler {
	associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler where Self: UIViewController, SegueIdentifier.RawValue == String {
	
	func performSegue(withIdentifier identifier: SegueIdentifier,
										sender: AnyObject?) {
		performSegue(withIdentifier: identifier.rawValue, sender: sender)
	}
	
	func segueIdentifier(forSegue segue: UIStoryboardSegue) -> SegueIdentifier {
		
		// still have to use guard stuff here, but at least you're
		// extracting it this time
		guard let identifier = segue.identifier,
			let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
				fatalError("Invalid segue identifier \(String(describing: segue.identifier)).") }
		
		return segueIdentifier
	}
}
