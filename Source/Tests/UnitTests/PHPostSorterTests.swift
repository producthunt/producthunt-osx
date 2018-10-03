//
//  PHPostSorterTests.swift
//  Product Hunt
//
//  Created by Vlado on 4/19/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import ReSwift

class PHPostSorterTests: PHTestCase {

    func testThatFiltersSeenPosts() {
        let seenPost    = fake.post()
        let unseenPost  = fake.post()

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])
        
        store.dispatch( PHMarkPostsAsSeenAction(posts: [seenPost]))

        let posts = PHPostSorter.filter(store, posts: [seenPost, unseenPost], by: [.seen(true)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatFiltersUnseenPosts() {
        let seenPost    = fake.post()
        let unseenPost  = fake.post()

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHMarkPostsAsSeenAction(posts: [seenPost]))

        let posts = PHPostSorter.filter(store, posts: [seenPost, unseenPost], by: [.seen(false)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatFiltersVotes() {
        let seenPost    = fake.post(0, votes: 9, commentsCount: 0)
        let unseenPost  = fake.post(0, votes: 15, commentsCount: 0)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        let posts = PHPostSorter.filter(store, posts: [seenPost, unseenPost], by: [PHPostFilter.votes(10)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatSortsByVotes() {
        let seenPost    = fake.post(0, votes: 10, commentsCount: 0)
        let unseenPost  = fake.post(0, votes: 15, commentsCount: 0)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        let posts = PHPostSorter.filter(store, posts: [seenPost, unseenPost], by: [PHPostFilter.sortByVotes])

         XCTAssertTrue(posts.first!.votesCount == 15)
    }

    func testThatSortsPostsByUnseenAndGivenVoteCount() {
        let seenPost = fake.post(0, votes: 100, commentsCount: 0)
        let unseenPost = fake.post(0, votes: 9, commentsCount: 0)
        let otherUnseenPost = fake.post(0, votes: 10, commentsCount: 0)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHMarkPostsAsSeenAction(posts: [seenPost]))

        let posts = PHPostSorter.sort(store, posts: [seenPost, unseenPost, otherUnseenPost], votes: 0)

        XCTAssertTrue(posts.first!.votesCount == 10)
    }
}
