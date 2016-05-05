//
//  PHSeenPostsModuleTests.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import ReSwift

class PHSeenPostsModuleTests: PHTestCase {

    struct BootStrapAction: Action {}

    func testThatReturnsState() {
        let reducer = seenPostsReducer(BootStrapAction(), state: nil)

        XCTAssertNotNil(reducer)
    }

    func testThatmarksPostAsSeen() {
        let post = fake.post()

        let seenPosts = PHSeenPosts(date: NSDate(timeIntervalSinceNow: 0), postIds: [])

        let action = PHMarkPostsAsSeenAction(posts: [post])

        let reducer = seenPostsReducer(action, state: seenPosts)

        XCTAssertTrue( reducer.postIds.contains(post.id) )
    }

    func testThatItResetsSeenPostsState() {
        let daysAgo = 1.days

        let yesterdayPost = fake.post(daysAgo, votes: 0, commentsCount: 0)

        let post = fake.post()

        let seenPosts = PHSeenPosts(date: NSDate(timeIntervalSinceNow: daysAgo), postIds: Set([yesterdayPost.id]))

        let action = PHMarkPostsAsSeenAction(posts: [post])

        let reducer = seenPostsReducer(action, state: seenPosts)

        XCTAssertTrue(reducer.date.isToday())
        XCTAssertEqual(reducer.postIds.count, 1)
        XCTAssertTrue(reducer.isSeen(yesterdayPost))
        XCTAssertTrue(reducer.isSeen(post))
    }

    func testThatAddsOnlyUnqueIds() {
        let post = fake.post()

        let seenPosts = PHSeenPosts(date: NSDate(), postIds: Set([post.id]))

        let action = PHMarkPostsAsSeenAction(posts: [post])

        let reducer = seenPostsReducer(action, state: seenPosts)

        XCTAssertTrue(reducer.isSeen(post))
        XCTAssertEqual(reducer.postIds.count, 1)
    }
}
