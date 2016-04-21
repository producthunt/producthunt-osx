//
//  PHPostFactory.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

extension PHPost {

    class func post(fromDictionary dictionary: [String: AnyObject]) -> PHPost? {
        guard
            let id              = dictionary["id"] as? Int,
            let title           = dictionary["name"] as? String,
            let tagline         = dictionary["tagline"] as? String,
            let day             = dictionary["day"] as? String,
            let discussionPath  = dictionary["discussion_url"] as? String,
            let thumbnail       = dictionary["thumbnail"] as? [String: AnyObject],
            let thumbnailPath   = thumbnail["image_url"] as? String,
            let votesCount      = dictionary["votes_count"] as? Int,
            let commentsCount   = dictionary["comments_count"] as? Int,
            let createdAt       = dictionary["created_at"] as? String,
            let redirectUrl     = dictionary["redirect_url"] as? String
        else {
            return nil
        }

        let thumbnailURL    = NSURL(string: thumbnailPath)!
        let discussionURL   = NSURL(string: discussionPath)!
        let redirectURL     = NSURL(string: redirectUrl)!

        return PHPost(id: id,title: title, tagline: tagline, thumbnailUrl: thumbnailURL, discussionUrl: discussionURL, day: day, votesCount: votesCount, commentsCount: commentsCount, createdAt: createdAt, redirectUrl: redirectURL)
    }

    class func posts(fromArray array: [[String: AnyObject]]) -> [PHPost] {
        return array.map{ PHPost.post(fromDictionary: $0)! }.filter({ $0 != nil })
    }

}