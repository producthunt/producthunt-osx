//
//  PHUserDefaultsTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHUserDefaultsTests: PHTestCase {

    override func setUp() {
        super.setUp()
        PHUserDefaults.resetUserDefaults()
    }

    override func tearDown() {
        super.tearDown()
        PHUserDefaults.resetUserDefaults()
    }

    func testThatItUpdatesLastUpdate() {
        let date = NSDate(timeIntervalSinceNow: -1000)

        PHUserDefaults.setLastUpdated(date)

        XCTAssertEqualWithAccuracy(date.timeIntervalSinceNow, PHUserDefaults.getLastUpdated().timeIntervalSinceNow, accuracy: 0.01)
    }

    func testThatItRerunsTodayIfNoLastUpdateDate() {
        PHUserDefaults.resetUserDefaults()

        XCTAssertTrue(PHUserDefaults.getLastUpdated().isToday())
    }

    func testThatSetsSeendPosts() {
        let date = NSDate(timeIntervalSinceNow: -1.day)

        let posts = [date.ISO8601String()! : [1]]

        PHUserDefaults.setSeenPosts(posts)

        let seenPosts = PHUserDefaults.getSeenPosts()

        XCTAssertTrue(NSDate(ISO8601String: seenPosts.keys.first!)!.isYesterday())
    }

    func testThatReturnsEmptySeenPostsFromTodayIfNoUserDefault() {
        let seenPosts = PHUserDefaults.getSeenPosts()

        XCTAssertTrue(NSDate(ISO8601String: seenPosts.keys.first!)!.isToday())
        XCTAssertEqual(seenPosts.values.first!.count, 0)
    }

    func testThatSavesShowsCount() {
        PHUserDefaults.setShowsCount(true)

        XCTAssertTrue(PHUserDefaults.getShowsCount())
    }

    func testThatSavesAutologin() {
        PHUserDefaults.setAutoLogin(true)

        XCTAssertTrue(PHUserDefaults.getAutoLogin())
    }

    func testThatSavesTokenInfo() {
        let token = PHToken(accessToken: "123test", expirationDate: NSDate(timeIntervalSinceNow: 1))

        PHUserDefaults.setTokenData(token.description())

        XCTAssertNotNil(PHUserDefaults.getTokenData()["access_token"])
    }

    func testThatReturnsDefaultNumberOfVotes() {
        PHUserDefaults.resetUserDefaults()

        XCTAssertEqual(PHUserDefaults.getFilterCount(), 10)
    }

    func testThatCanSetNumberOfVotes() {
        let votesTreshold = 50

        PHUserDefaults.setFilterCount(votesTreshold)

        XCTAssertEqual(PHUserDefaults.getFilterCount(), votesTreshold)
    }

    func testThatRegisterDefaults() {
        PHUserDefaults.registerDefaults()

        // Last updated should be today
        XCTAssertTrue(PHUserDefaults.getLastUpdated().isToday())

        // Seen posts should be empty array
        let seenPosts = PHUserDefaults.getSeenPosts()

        XCTAssertTrue(NSDate(ISO8601String: seenPosts.keys.first!)!.isToday())
        XCTAssertEqual(seenPosts.values.first!.count, 0)

        // Shows count enabled
        XCTAssertTrue(PHUserDefaults.getShowsCount())

        // Auto login enabled
        XCTAssertTrue(PHUserDefaults.getAutoLogin())

        // Empty token data
        XCTAssertNotNil(PHUserDefaults.getTokenData())
    }
}
