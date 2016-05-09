//
//  Credentials.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

public class Credentials {

    /** Returns this string encoded as Base64. */
    static func base64(string: String) -> String {
        let utf8str = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        return utf8str.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }

    /** Returns an auth credential for the Basic scheme. Exposed for testing. */
    static func basic(username: String, password: String) -> String {
        return String(format: "Basic %@", base64(String(format: "%@:%@", username, password)))
    }

}
