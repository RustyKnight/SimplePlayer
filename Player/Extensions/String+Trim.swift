//
//  String+Trim.swift
//  Secure
//
//  Created by Shane Whitehead on 29/8/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation

extension String {
	var trimmed: String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	var isEmptyWhenTrimmed: Bool {
		return self.trimmed.isEmpty
	}
}
