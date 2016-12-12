//
//  ProductHunt.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

extension XCTestCase {

    func ph_expectation(_ description: String, fulfill: (_ expectation: XCTestExpectation) -> Void) {
        let expectation = self.expectation(description: description)

        fulfill(expectation)

        waitForExpectations(timeout: 5, handler: nil)
    }

}
