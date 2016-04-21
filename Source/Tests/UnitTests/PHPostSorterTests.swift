//
//  PHPostSorterTests.swift
//  Product Hunt
//
//  Created by Vlado on 4/19/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHPostSorterTests: PHTestCase {

    func testThatFiltersSeenPosts() {
        let seenPost    = fake.post()
        let unseenPost  = fake.post()

        PHSeenPosts.markAsSeen(seenPost)

        let posts = PHPostSorter.filter([seenPost, unseenPost], by: [.Seen(true)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatFiltersUnseenPosts() {
        let seenPost    = fake.post()
        let unseenPost  = fake.post()

        PHSeenPosts.markAsSeen(seenPost)

        let posts = PHPostSorter.filter([seenPost, unseenPost], by: [.Seen(false)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatFiltersVotes() {
        let seenPost    = fake.post(0, votes: 9, commentsCount: 0)
        let unseenPost  = fake.post(0, votes: 15, commentsCount: 0)

        let posts = PHPostSorter.filter([seenPost, unseenPost], by: [PHPostFilter.Votes(10)])

        XCTAssertTrue(posts.count == 1)
    }

    func testThatSortsByVotes() {
        let seenPost    = fake.post(0, votes: 10, commentsCount: 0)
        let unseenPost  = fake.post(0, votes: 15, commentsCount: 0)

        let posts = PHPostSorter.filter([seenPost, unseenPost], by: [PHPostFilter.SortByVotes])

         XCTAssertTrue(posts.first!.votesCount == 15)
    }

    func testThatSortsPostsByUnseenAndGivenVoteCount() {
        let seenPost = fake.post(0, votes: 100, commentsCount: 0)
        let unseenPost = fake.post(0, votes: 9, commentsCount: 0)
        let otherUnseenPost = fake.post(0, votes: 10, commentsCount: 0)

        PHSeenPosts.markAsSeen(seenPost)

        let posts = PHPostSorter.sort([seenPost, unseenPost, otherUnseenPost], votes: 0)

        XCTAssertTrue(posts.first!.votesCount == 10)
    }
}
