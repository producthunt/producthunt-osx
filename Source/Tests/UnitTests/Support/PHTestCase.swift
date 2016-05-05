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

    var fake = PHFakeFactory.sharedInstance
    
    var endpoint = PHAPIFakeEndpoint(token: PHFakeFactory.sharedInstance.token())

    override func setUp() {
        super.setUp()

        PHAPI.sharedInstance.endpoint = endpoint
    }

    override func tearDown() {
        super.tearDown()
    }
}
