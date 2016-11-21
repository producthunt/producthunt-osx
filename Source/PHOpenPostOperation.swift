//
//  PHOpenPostOperation.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHOpenPostOperation {

    fileprivate class var openExternalLink: Bool {
        var openExternalLink = false

        if let event = NSApp.currentEvent, event.modifierFlags.contains(.command) && event.modifierFlags.contains(.option)  {
            openExternalLink = true
        }

        return openExternalLink
    }

    class func perform(withPost post: PHPost) {
        let url = openExternalLink ? post.redirectUrl : post.discussionUrl

        PHOpenURLAction.perform(withUrl:  url, closeAfterLaunch: true)

        PHMarkAsSeenOperation.perform(post)

        PHAnalitycsOperation.performTrack(post)
    }

}
