//
//  PHShowPostAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHOpenPostAction {

    private class var openExternalLink: Bool {
        var openExternalLink = false

        if let event = NSApp.currentEvent where event.modifierFlags.contains(.CommandKeyMask) && event.modifierFlags.contains(.AlternateKeyMask)  {
            openExternalLink = true
        }

        return openExternalLink
    }

    class func perform(withPost post: PHPost) {
        let url = openExternalLink ? post.redirectUrl : post.discussionUrl

        PHOpenURLAction.perform(withUrl:  url, closeAfterLaunch: true)

        PHSeenPosts.markAsSeen(post)
    }
}