//
//  PHPostsModuleTests.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import ReSwift

class PHPostsModuleTests: PHTestCase {

    struct BootStrapAction: Action {}

    func testThatReturnsState() {
        let posts = postsReducer(BootStrapAction(), state: nil)
        
        XCTAssertNotNil(posts)
    }

    func testThatAcceptsEmptyArray() {
        let state = PHAppStatePosts(sections: [], lastUpdated: Date())

        let reducer = postsReducer(PHPostsLoadAction(posts: []) , state: state)

        XCTAssertNotNil(reducer)
    }

    func testThatOldPostsAppendsSectionAtTheEnd() {
        let section = PHSection.section( [fake.post(-1.day, votes: 10, commentsCount: 10)] )

        let state = PHAppStatePosts(sections: [section], lastUpdated: Date())

        let post = fake.post(-2.day, votes: 10, commentsCount: 10)

        let action = PHPostsLoadAction(posts: [post])

        let reducer = postsReducer(action, state: state)

        XCTAssertEqual(reducer.sections.count, 2)
        XCTAssertEqual(reducer.sections.last!.posts.first!.id, post.id)
    }

    func testThatNewPostsAppendsSectionAtFront() {
        let section = PHSection.section( [fake.post(-1.day, votes: 10, commentsCount: 10)] )

        let state = PHAppStatePosts(sections: [section], lastUpdated: Date())

        let post = fake.post()

        let action = PHPostsLoadAction(posts: [post])

        let reducer = postsReducer(action, state: state)

        XCTAssertEqual(reducer.sections.count, 2)
        XCTAssertEqual(reducer.sections.first!.posts.first!.id, post.id)
    }

    func testThatReplacesTodaySection() {
        let section = PHSection.section( [fake.post()] )

        let state = PHAppStatePosts(sections: [section], lastUpdated: Date())

        let post = fake.post()

        let action = PHPostsLoadAction(posts: [post])

        let reducer = postsReducer(action, state: state)

        XCTAssertEqual(reducer.sections.count, 1)
        XCTAssertEqual(reducer.sections.first!.posts.first!.id, post.id)
    }
}
