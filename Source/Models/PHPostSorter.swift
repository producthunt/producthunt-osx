//
//  PHPostSorter.swift
//  Product Hunt
//
//  Created by Vlado on 4/19/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

enum PHPostFilter {
    case Seen(Bool), Votes(Int), SortByVotes, None
}

class PHPostSorter {

    class func filter(posts:[PHPost], by:[PHPostFilter]) -> [PHPost] {
        return by.reduce(posts, combine: { (posts, filter) -> [PHPost] in
            switch(filter) {
            case .Seen(let seen):
                return posts.filter { (seen ? PHSeenPosts.isSeen($0) : !PHSeenPosts.isSeen($0)) }

            case .Votes(let votesCount):
                return posts.filter { $0.votesCount >= votesCount }

            case .SortByVotes:
                return posts.sort({ $0.votesCount > $1.votesCount })

            case .None:
                return posts
            }
        })
    }

    class func sort(posts: [PHPost], votes: Int) -> [PHPost] {
        return filter(posts, by: [.Seen(false), .Votes(votes), .SortByVotes]) + filter(posts, by: [.Seen(true), .SortByVotes])
    }
}