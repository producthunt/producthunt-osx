//
//  PHAppState.swift
//  Product Hunt
//
//  Created by Vlado on 4/27/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import ReSwift

struct PHAppState: StateType {
    var settings: PHSettings
    var posts: PHAppStatePosts
    var seenPosts: PHSeenPosts
    var token: PHToken
}