//
//  PHCallbacks.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHVoidCallback = (Void) -> Void
typealias PHAPIErrorClosure = (_ error: NSError) -> ()
typealias PHAPIOperationClosure = (_ api: PHAPI,_ errorClosure: @escaping PHAPIErrorClosure) -> ()
typealias PHAPITokenCompletion  = ((_ token: PHToken?, _ error: NSError?) -> ())
typealias PHAPIPostCompletion   = ((_ posts: [PHPost], _ error: NSError?) -> ())
