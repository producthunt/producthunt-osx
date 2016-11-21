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

    var isValid: Bool {
        return !accessToken.isEmpty
    }

    func description() -> [String: AnyObject] {
        return ["access_token" : accessToken as AnyObject]
    }
}
