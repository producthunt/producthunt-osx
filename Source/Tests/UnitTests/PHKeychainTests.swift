//
//  PHKeychainTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHKeychainTests: PHTestCase {

    override func setUp() {
        super.setUp()
        PHUserDefaults.resetUserDefaults()
    }

    override func tearDown() {
        PHUserDefaults.resetUserDefaults()
        super.tearDown()
    }

    func testThatSavesToken() {
        let token = PHToken(accessToken: "123abc", expirationDate: NSDate(timeIntervalSinceNow: 60))

        PHKeychain.setToken(token)

        XCTAssertNotNil(PHKeychain.getToken())
    }

    func testThatReplacesToken() {
        let token = PHToken(accessToken: "123abc", expirationDate: NSDate(timeIntervalSinceNow: 60))

        PHKeychain.setToken(token)

        let newToken = PHToken(accessToken: "123", expirationDate: NSDate(timeIntervalSinceNow: 120))

        PHKeychain.setToken(newToken)

        XCTAssertTrue(PHKeychain.getToken()?.accessToken == newToken.accessToken)
    }

    func testThatTokenIsNilIfExpires() {
        let token = PHToken(accessToken: "123abc", expirationDate: NSDate(timeIntervalSinceNow: -60))

        PHKeychain.setToken(token)

        XCTAssertNil(PHKeychain.getToken())
    }

    func testThatResetsToken() {
        let token = PHToken(accessToken: "123abc", expirationDate: NSDate(timeIntervalSinceNow: 60))

        PHKeychain.setToken(token)

        XCTAssertNotNil(PHKeychain.getToken())

        PHKeychain.resetToken()

        XCTAssertNil(PHKeychain.getToken())
    }

}
