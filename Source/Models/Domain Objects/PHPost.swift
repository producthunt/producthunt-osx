//
//  PHPost.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHPost {

    var id: Int
    var title: String
    var tagline: String
    var thumbnailUrl: URL
    var discussionUrl: URL
    var day: String
    var votesCount: Int
    var commentsCount: Int
    var createdAt: String
    var redirectUrl: URL

    init(id: Int, title: String, tagline: String, thumbnailUrl: URL, discussionUrl: URL, day: String, votesCount: Int, commentsCount: Int, createdAt: String, redirectUrl: URL) {
        self.id             = id
        self.title          = title
        self.tagline        = tagline
        self.thumbnailUrl   = thumbnailUrl
        self.discussionUrl  = discussionUrl
        self.day            = day
        self.votesCount     = votesCount
        self.commentsCount  = commentsCount
        self.createdAt      = createdAt
        self.redirectUrl    = redirectUrl
    }

    func description() -> [String: Any] {
        return [
            "id"                : id,
            "name"              : title,
            "tagline"           : tagline,
            "day"               : day,
            "discussion_url"    : discussionUrl.absoluteString,
            "thumbnail"         : ["image_url" : thumbnailUrl.absoluteString],
            "votes_count"       : votesCount,
            "comments_count"    : commentsCount,
            "created_at"        : createdAt,
            "redirect_url"      : redirectUrl.absoluteString
        ]
    }

}
