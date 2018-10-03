//
//  PHPostDataSourceTests.swift
//  ProductHunt
//
//  Created by Vlado on 3/31/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest
import ReSwift

class PHPostDataSourceTests: PHTestCase {

    override func tearDown() {
        super.tearDown()
    }

    func testReturnsCountOfRows() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)
        
        source.loadNewer()

        XCTAssertTrue(source.numberOfRows() == 2)
    }

    func testThatReturnsSectionAtIndex() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)

        source.loadNewer()

        XCTAssertNotNil(source.data(atIndex: 0) as? String)
    }

    func testThatReturnsPostAtIndex() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)

        source.loadNewer()

        XCTAssertNotNil(source.data(atIndex: 1) as? PHPost)
    }

    func testThatRerurnsTrueIfSectionIsGroup() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)

        source.loadNewer()

        XCTAssertTrue(source.isGroup(atIndex: 0))
        XCTAssertFalse(source.isGroup(atIndex: 1))
    }

    func testLoadsNewer() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)

        source.loadNewer()

        XCTAssertEqual(source.numberOfRows(), 2)
    }

    func testLoadsOlder() {
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [fake.post().description()]], error: nil)
        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 1, "search[category]": "all"], response: ["posts" : [fake.post(-1.day, votes: 10, commentsCount: 0).description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        let source = PHPostsDataSource(store: store)

        source.loadNewer()
        source.loadOlder()

        XCTAssertEqual(source.numberOfRows(), 4)
    }

    func testThatFiltersPostsWithGivenVoteCount() {
        let firstPost = fake.post(0, votes: 51, commentsCount: 0)
        let secondPosts = fake.post(0, votes: 25, commentsCount: 0)

        endpoint.addFake("GET", url: "posts", parameters: ["days_ago": 0, "search[category]": "all"], response: ["posts" : [firstPost.description(), secondPosts.description()]], error: nil)

        let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

        store.dispatch( PHTokenGetAction(token: fake.token() ))

        store.dispatch( PHSettngsActionFilterCount(filterCount: 50) )

        let source = PHPostsDataSource(store: store)

        source.loadNewer()

        XCTAssertEqual(source.numberOfRows(), 2)
    }
}
