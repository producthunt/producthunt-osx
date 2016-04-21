//
//  PHSeenPostsTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHSeenPostsTests: PHTestCase {

    override func setUp() {
        super.setUp()
        PHUserDefaults.resetUserDefaults()
    }

    func testThatMarksAllAsSeen() {
        let post = fake.post()
        let secondsPost = fake.post()

        PHSeenPosts.markAllAsSeen([post, secondsPost])

        XCTAssertTrue(PHSeenPosts.isSeen(post))
        XCTAssertTrue(PHSeenPosts.isSeen(secondsPost))
    }

    func testThatCreatesNewInteractionsIfNoKey() {
        let post = fake.post(0.seconds)

        PHSeenPosts.markAsSeen(post)

        XCTAssertTrue(PHSeenPosts.isSeen(post))
    }

    func testThatAppendsPostIdIfAlreadyHaveInteractionsForToday() {
        let post = fake.post(0.days)
        PHSeenPosts.markAsSeen(post)

        let secondPost = fake.post(0.days)
        PHSeenPosts.markAsSeen(secondPost)

        XCTAssertTrue(PHSeenPosts.isSeen(post))
        XCTAssertTrue(PHSeenPosts.isSeen(secondPost))
    }

    func testThatCreatesNewInteractionsIfNewdDay() {
        let post = fake.post(1.days)
        PHSeenPosts.markAsSeen(post)

        let secondPost = fake.post(0.days)
        PHSeenPosts.markAsSeen(secondPost)

        XCTAssertTrue(PHSeenPosts.isSeen(post))
        XCTAssertTrue(PHSeenPosts.isSeen(secondPost))
    }

    func testThatIfPostIsMoreThanOneDayOlderWontSaveToInteractions() {
        let post = fake.post(0.days)
        PHSeenPosts.markAsSeen(post)

        let secondPost = fake.post(1.days)
        PHSeenPosts.markAsSeen(secondPost)

        XCTAssertTrue(PHSeenPosts.isSeen(post))
        XCTAssertTrue(PHSeenPosts.isSeen(secondPost))
    }

    func testThatReturnsFalseIfPostIsNotInInteractions() {
        print(PHUserDefaults.getSeenPosts())

        let post = fake.post(0.seconds)

        XCTAssertFalse(PHSeenPosts.isSeen(post))
    }
}
