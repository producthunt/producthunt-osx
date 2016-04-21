//
//  PHSeenPosts.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import DateTools
import ISO8601

class PHSeenPosts {

    class func markAllAsSeen(posts: [PHPost]?) {
        guard let posts = posts else {
            return
        }

        let votesTreshold = PHUserDefaults.getFilterCount()
        
        let filters: [PHPostFilter] = [.Seen(false), .Votes(votesTreshold)]

        PHPostSorter.filter(posts, by: filters).forEach({ markAsSeen($0) })

        PHAppContext.sharedInstance.notify(.Newer)
    }

    class func markAsSeen(post: PHPost) {
        if !isFromToday(post) {
            return
        }

        let seenPosts = PHUserDefaults.getSeenPosts()

        var seenIDs = [post.id]

        if let key = seenPosts.keys.first, let date = NSDate(ISO8601String: key), var ids = seenPosts[key] as? [Int] where date.isSameDay(NSDate(ISO8601String: post.day)) {
            ids.append(post.id)
            seenIDs = ids
        }

        PHUserDefaults.setSeenPosts(["\(post.day)" : seenIDs])

        PHAppContext.sharedInstance.notify(.Newer)
    }

    class func isSeen(post: PHPost) -> Bool {
        if !isFromToday(post) {
            return true
        }

        let seenPosts = PHUserDefaults.getSeenPosts()

        guard let key = seenPosts.keys.first, let ids = seenPosts[key] as? [Int] else {
            return true
        }

        return ids.contains(post.id)
    }

    private class func isFromToday(post: PHPost) -> Bool {
        return PHDateFormatter().daysAgo(fromDateAsString: post.day) == 0
    }
}