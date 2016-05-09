//
//  PHAnalitycsOperation.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHAnalitycsOperation {

    class func performTrack(post: PHPost) {
        store.dispatch( PHTrackPostAction(post: post) )
    }

    class func performTrackShare(post: PHPost, medium: String) {
        store.dispatch( PHTrackPostShare(post: post, medium: medium) )
    }

    class func performTrackVisit(page: String) {
        store.dispatch( PHTrackVisit(page: page) )
    }
}