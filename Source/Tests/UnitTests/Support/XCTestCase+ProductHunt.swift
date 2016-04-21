//
//  ProductHunt.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

extension XCTestCase {

    func ph_expectation(description: String, fulfill: (expectation: XCTestExpectation) -> Void) {
        let expectation = expectationWithDescription(description)

        fulfill(expectation: expectation)

        waitForExpectationsWithTimeout(5, handler: nil)
    }

}
