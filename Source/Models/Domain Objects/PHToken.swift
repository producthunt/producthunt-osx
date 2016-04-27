//
//  PHToken.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

struct PHToken {

    var accessToken: String
    var expirationDate: NSDate

    var isValid: Bool {
        return expirationDate.isLaterThan(NSDate())
    }

    func description() -> [String: AnyObject] {
        return ["access_token" : accessToken, "expires_in" : expirationDate.timeIntervalSinceNow]
    }
}
