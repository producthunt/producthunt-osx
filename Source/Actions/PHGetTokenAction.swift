//
//  PHGetTokenAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/21/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHGetTokenAction {

    class func perform(completion: PHVoidCallback) {
        if hasValidToken() {
            completion()
            return
        }

        PHAPI.sharedInstance.getToken { (token, error) in
            if let token = token {
                PHKeychain.setToken(token)
                PHAPI.sharedInstance.endpoint.updateAuthorizationToken(token)
            }

            completion()
        }
    }

    private class func hasValidToken() -> Bool {
        guard let token = PHKeychain.getToken() else {
            return false
        }

        return !token.accessToken.isEmpty
    }
}