//
//  PHPostViewModel.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHPostViewModel {

    var isSeen: Bool {
        return PHSeenPosts.isSeen(post)
    }

    var title: String {
        return post.title
    }

    var tagline: String {
        return post.tagline
    }

    var thumbnailUrl: NSURL {
        return post.thumbnailUrl
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

    private var post: PHPost
    private var formatter = PHDateFormatter()

    init(withPost post: PHPost) {
        self.post = post
    }
}