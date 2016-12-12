//
//  PHPostViewModel.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import ReSwift

class PHPostViewModel {

    var isSeen: Bool {
        return  store.state.seenPosts.isSeen(post)
    }

    var title: String {
        return post.title
    }

    var tagline: String {
        return post.tagline
    }

    var thumbnailUrl: URL {
        return post.thumbnailUrl as URL
    }

    var votesCount: String {
        return "\(post.votesCount)"
    }

    var commentsCount: String {
        return "\(post.commentsCount)"
    }

    var createdAt: String {
        return formatter.timeAgo(fromDateAsString: post.createdAt)
    }

    fileprivate var post: PHPost
    fileprivate var store: Store<PHAppState>
    fileprivate var formatter = PHDateFormatter()

    init(withPost post: PHPost, store: Store<PHAppState>) {
        self.post = post
        self.store = store
    }
}
