//
//  PHtestCase.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import DateTools
import SwiftyTimer

class PHTestCase: XCTestCase {

    var endpoint = PHAPIFakeEndpoint()
    var fake = PHFakeFactory.sharedInstance

    override func setUp() {
        super.setUp()

        PHAPI.sharedInstance.endpoint = endpoint
    }

    override func tearDown() {
        super.tearDown()
    }

}
