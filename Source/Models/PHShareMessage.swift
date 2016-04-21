//
//  PHShareMessage.swift
//  ProductHunt
//
//  Created by Vlado on 4/6/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHShareMessage {

    class func message(fromPost post: PHPost) -> String {
        return "\(post.title): \(post.tagline) \(post.discussionUrl)"
    }
}