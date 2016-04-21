//
//  PHPostViewModelTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHPostViewModelTests: PHTestCase {

    override func setUp() {
        super.setUp()
        PHUserDefaults.resetUserDefaults()
    }

    func testThatRerurnsTitle() {
        let post = fake.post()

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.title == post.title)
    }

    func testThatReturnsThumbnailUrl() {
        let post = fake.post()

        let model = PHPostViewModel(withPost: post)

        XCTAssertNotNil(model.thumbnailUrl)
    }

    func testThatRerurnsTagline() {
        let post = fake.post()

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.tagline == post.tagline)
    }

    func testThatSeenIsTrueIfPostIsOlderThanOneDay() {
        let post = fake.post(1.days)

        PHSeenPosts.markAsSeen(post)

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.isSeen)
    }

    func testThatSeenIsFalseIfNotInInteractions() {
        let post = fake.post()

        let model = PHPostViewModel(withPost: post)

        XCTAssertFalse(model.isSeen)
    }

    func testThatSeenIsTrueIfPostIsInInteractions() {
        let post = fake.post()

        PHSeenPosts.markAsSeen(post)

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.isSeen)
    }

    func testThatReturnsVotesCount() {
        let post = fake.post(0.seconds, votes: 10, commentsCount: 10)

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.votesCount == "10")
    }

    func testThatReturnsCommentsCount() {
        let post = fake.post(0.seconds, votes: 10, commentsCount: 10)

        let model = PHPostViewModel(withPost: post)

        XCTAssertTrue(model.commentsCount == "10")
    }
}
