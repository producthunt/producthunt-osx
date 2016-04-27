//
//  PHPostSorter.swift
//  Product Hunt
//
//  Created by Vlado on 4/19/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

enum PHPostFilter {
    case Seen(Bool), Votes(Int), SortByVotes, None
}

class PHPostSorter {

    class func filter(store: Store<PHAppState>, posts:[PHPost], by:[PHPostFilter]) -> [PHPost] {
        return by.reduce(posts, combine: { (posts, filter) -> [PHPost] in
            switch(filter) {

                case .Seen(let seen):
                    let seenIds = store.state.seenPosts.postIds
                    return posts.filter { (seen ? seenIds.contains($0.id) : !seenIds.contains($0.id) ) }

                case .Votes(let votesCount):
                    return posts.filter { $0.votesCount >= votesCount }

                case .SortByVotes:
                    return posts.sort({ $0.votesCount > $1.votesCount })

                case .None:
                    return posts
            }
        })
    }

    class func sort(store: Store<PHAppState> ,posts: [PHPost], votes: Int) -> [PHPost] {
        return filter(store, posts: posts, by: [.Seen(false), .Votes(votes), .SortByVotes]) + filter(store, posts: posts, by: [.Seen(true), .SortByVotes])
    }
}