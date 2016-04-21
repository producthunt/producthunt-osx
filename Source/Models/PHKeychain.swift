//
//  PHKeychain.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

/// Previously `Keychain` was used. Due to issue from Apple, keychain access returns OSStatus -34058.
/// For now store tokens in NSUserDefaults.
class PHKeychain {

    class func setToken(token: PHToken) {
        PHUserDefaults.setTokenData(token.description())
    }

    class func getToken() -> PHToken? {
        return PHToken.token(fromDictionary: PHUserDefaults.getTokenData())
    }

    class func resetToken() {
        PHUserDefaults.setTokenData([String : AnyObject]())
    }
}