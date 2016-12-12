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
    case seen(Bool), votes(Int), sortByVotes, none
}

class PHPostSorter {

    class func filter(_ store: Store<PHAppState>, posts:[PHPost], by:[PHPostFilter]) -> [PHPost] {
        return by.reduce(posts, { (posts, filter) -> [PHPost] in
            switch(filter) {

                case .seen(let seen):
                    let seenIds = store.state.seenPosts.postIds
                    return posts.filter { (seen ? seenIds.contains($0.id) : !seenIds.contains($0.id) ) }

                case .votes(let votesCount):
                    return posts.filter { $0.votesCount >= votesCount }

                case .sortByVotes:
                    return posts.sorted(by: { $0.votesCount > $1.votesCount })

                case .none:
                    return posts
            }
        })
    }

    class func sort(_ store: Store<PHAppState> ,posts: [PHPost], votes: Int) -> [PHPost] {
        return filter(store, posts: posts, by: [.seen(false), .votes(votes), .sortByVotes]) + filter(store, posts: posts, by: [.seen(true), .sortByVotes])
    }
}
