//
//  PHPostFetcherTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHPostFetcherTests: PHTestCase {

    func testLoadNewer() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let fetcher = PHPostFetcher(context: PHAppContext())
        fetcher.loadNewer()

        XCTAssertEqual(fetcher.content.count, 1)
    }

    func testThatIfNoPostsTodayLoadsYestedays()  {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: [String : AnyObject](), error: nil)
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 1, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let fetcher = PHPostFetcher(context: PHAppContext())
        fetcher.loadNewer()

        XCTAssertEqual(fetcher.content.count, 1)
    }

    func testThatLoadsOlder() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 1, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let fetcher = PHPostFetcher(context: PHAppContext())
        fetcher.loadOlder()

        XCTAssertEqual(fetcher.content.count, 1)
    }
}
