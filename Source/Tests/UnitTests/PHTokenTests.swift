//
//  PHTokenTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHTokenTests: PHTestCase {

    func testTokenFactoryRetunsNilIfInvalidAccessToken() {
        let data = ["access_token": NSNull(), "expires_in" : 60]
        XCTAssertNil(PHToken.token(fromDictionary: data))
    }

    func testTokenFactoryReturnsNilIfInvalidExpirationInterval() {
        let data = ["access_token": "123abc", "expires_in" : NSNull()]
        XCTAssertNil(PHToken.token(fromDictionary: data))
    }

    func testTokenValidityDate() {
        let data = ["access_token": "123abc", "expires_in" : 60]
        let token = PHToken.token(fromDictionary: data)!
        let date = NSDate(timeIntervalSinceNow: 60)

        XCTAssertEqualWithAccuracy(date.timeIntervalSinceNow, token.expirationDate.timeIntervalSinceNow, accuracy: 0.01)
    }

    func testThatReturnsFalseIfTokenIsExpired() {
        let token = PHToken(accessToken: "", expirationDate: NSDate(timeIntervalSince1970: 0) )

        XCTAssertFalse(token.isValid)
    }

    func testThatReturnsTrueIfTokenIsExpired() {
        let token = PHToken(accessToken: "", expirationDate: NSDate(timeIntervalSinceNow: 100) )

        XCTAssertTrue(token.isValid)
    }
}
