//
//  PHShareAction.swift
//  ProductHunt
//
//  Created by Vlado on 4/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import Kingfisher
import ReSwift

class PHShareAction: NSObject, NSSharingServiceDelegate {

    static let sharedInstance = PHShareAction()

    func performTwitter(post: PHPost?) {
        guard let post = post else {
            return
        }

        store.dispatch( PHTrackPostShare(post: post, medium: "twitter") )

        KingfisherManager.sharedManager.retrieveImageWithURL(post.thumbnailUrl, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            self.perform(NSSharingServiceNamePostOnTwitter, title: PHShareMessage.message(fromPost: post), url: post.discussionUrl, image: image)
        }
    }

    func performFacebook(post: PHPost?) {
        guard let post = post else {
            return
        }

        store.dispatch( PHTrackPostShare(post: post, medium: "facebook") )

        KingfisherManager.sharedManager.retrieveImageWithURL(post.thumbnailUrl, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            self.perform(NSSharingServiceNamePostOnFacebook, title: PHShareMessage.message(fromPost: post), url: post.discussionUrl, image: image)
        }
    }

    private func perform(service: String, title: String, url: NSURL, image: NSImage?) {
        if let service =  NSSharingService(named: service) {
            service.delegate = self

            var items = [AnyObject]()

            items.append(title)

            if let image = image {
                items.append(image)
            }

            service.performWithItems(items)
        }
    }
}