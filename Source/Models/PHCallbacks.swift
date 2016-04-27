//
//  PHCallbacks.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHVoidCallback = Void -> Void
typealias PHAPIErrorClosure = (error: NSError) -> ()
typealias PHAPIOperationClosure = (api: PHAPI,errorClosure: PHAPIErrorClosure) -> ()
typealias PHAPITokenCompletion  = ((token: PHToken?, error: NSError?) -> ())
typealias PHAPIPostCompletion   = ((posts: [PHPost], error: NSError?) -> ())