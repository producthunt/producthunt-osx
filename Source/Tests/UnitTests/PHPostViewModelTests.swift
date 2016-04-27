//
//  PHPostViewModelTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import ReSwift

class PHPostViewModelTests: PHTestCase {

    func testThatRerurnsTitle() {
        let post = fake.post()

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertTrue(model.title == post.title)
    }

    func testThatReturnsThumbnailUrl() {
        let post = fake.post()

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertNotNil(model.thumbnailUrl)
    }

    func testThatRerurnsTagline() {
        let post = fake.post()

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertTrue(model.tagline == post.tagline)
    }

    func testThatSeenIsTrueIfPostIsOlderThanOneDay() {
        let post = fake.post(1.days)

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        store.dispatch( PHMarkPostsAsSeenAction(posts: [post]) )

        XCTAssertTrue(model.isSeen)
    }

    func testThatSeenIsFalseIfNotInInteractions() {
        let post = fake.post()

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertFalse(model.isSeen)
    }

    func testThatSeenIsTrueIfPostIsInInteractions() {
        let post = fake.post()

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        store.dispatch( PHMarkPostsAsSeenAction(posts: [post]) )

        XCTAssertTrue(model.isSeen)
    }

    func testThatReturnsVotesCount() {
        let post = fake.post(0.seconds, votes: 10, commentsCount: 10)

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertTrue(model.votesCount == "10")
    }

    func testThatReturnsCommentsCount() {
        let post = fake.post(0.seconds, votes: 10, commentsCount: 10)

        let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

        let model = PHPostViewModel(withPost: post, store: store)

        XCTAssertTrue(model.commentsCount == "10")
    }
}
