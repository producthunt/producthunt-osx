//
//  PHSeenPostsModule.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

struct PHSeenPosts {
    var date: NSDate
    var postIds: Set<Int>

    func isSeen(post: PHPost) -> Bool {
        if PHDateFormatter.daysAgo(post.day) > 0 {
            return true
        }

        return postIds.contains(post.id)
    }
}

struct PHSeenPostsSetAction: Action {
    var seenPost: PHSeenPosts
}

struct PHMarkPostsAsSeenAction: Action {
    var posts: [PHPost]
}

func seenPostsReducer(action: Action, state: PHSeenPosts?) -> PHSeenPosts {
    let state = state ?? PHSeenPosts(date: NSDate(), postIds: Set<Int>())

    switch action {
        case let action as PHSeenPostsSetAction:
            return action.seenPost

        case let action as PHMarkPostsAsSeenAction:
            let date    = state.date.isToday() ? state.date     : NSDate()
            let postIds = state.date.isToday() ? state.postIds  : Set<Int>()

            let ids = action.posts.map{ $0.id }

            return PHSeenPosts(date: date, postIds: postIds.union(ids))

        default:
            return state
    }
}