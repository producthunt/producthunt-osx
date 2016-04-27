//
//  PHSeenPosts.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

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