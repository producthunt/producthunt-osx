//
//  PHTokenFactory.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

extension PHToken {

    static func token(fromDictionary dictionary: [String: AnyObject]?) -> PHToken? {
        guard let dictionary = dictionary, let accessToken = dictionary["access_token"] as? String, let expires = dictionary["expires_in"] as? NSTimeInterval else {
            return nil
        }

        let expirationDate = NSDate(timeIntervalSinceNow: expires)
        if expirationDate.compare(NSDate()) == NSComparisonResult.OrderedAscending {
            return nil
        }

        return PHToken(accessToken: accessToken, expirationDate: expirationDate)
    }

}