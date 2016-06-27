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
        let data = ["access_token": NSNull()]
        XCTAssertNil(PHToken.token(fromDictionary: data))
    }

    func testThatReturnsFalseIfTokenIsExpired() {
        let token = PHToken(accessToken: "")

        XCTAssertFalse(token.isValid)
    }

    func testThatReturnsTrueIfTokenIsExpired() {
        let token = PHToken(accessToken: "3asdsfgdsv" )

        XCTAssertTrue(token.isValid)
    }
}
