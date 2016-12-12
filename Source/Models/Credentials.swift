//
//  Credentials.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

open class Credentials {

    /** Returns this string encoded as Base64. */
    static func base64(_ string: String) -> String {
        let utf8str = string.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        return utf8str.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }

    /** Returns an auth credential for the Basic scheme. Exposed for testing. */
    static func basic(_ username: String, password: String) -> String {
        return String(format: "Basic %@", base64(String(format: "%@:%@", username, password)))
    }

}
