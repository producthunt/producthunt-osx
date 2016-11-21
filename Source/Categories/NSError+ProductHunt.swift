//
//  NSError+ProductHunt.swift
//  ProductHunt
//
//  Created by Vlado on 3/29/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

extension NSError {

    class func parseError(_ error: NSError?) -> NSError? {
        if let error = error, (error.userInfo[NSLocalizedDescriptionKey] as? String)?.contains("401") != nil {
            return unauthorizedError()
        }

        return error
    }

    class func unauthorizedError() -> NSError {
        return NSError(domain: "com.producthunt", code: 401, userInfo: nil)
    }
}
