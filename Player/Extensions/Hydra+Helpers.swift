//
//  Hydra+Helpers.swift
//  CleanSweep
//
//  Created by Shane Whitehead on 1/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import Hydra

func async(in context: Context, block: @escaping () throws -> Void) -> Promise<Void> {
	return Promise<Void>(in: context, { (fulfill, fail, _) in
		try block()
		fulfill(())
	})
}

func after(in context: Context = .userInitiated, _ seconds: TimeInterval) -> Promise<Void> {
  return Promise<Void>(resolved: ()).defer(in: context, seconds)
}
