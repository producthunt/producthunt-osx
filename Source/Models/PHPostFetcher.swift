//
//  PHPostFetcher.swift
//  ProductHunt
//
//  Created by Vlado on 3/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHFetcherCompletion = (section: PHSection?) -> ()

class PHPostFetcher {

    weak var context: PHAppContext?

    private(set) var content = [PHSection]()
    private let formatter = PHDateFormatter()
    private var isThereOngoingRequest = false

    init(context: PHAppContext) {
        self.context = context
    }

    func loadNewer() {
        if isThereOngoingRequest {
            return
        }

        getPostsPosted(0) { (section) in
            if let firstSection = self.content.first, let section = section where firstSection.day == section.day {
                self.content[0] = section
            } else if let section = section {
                self.content.insert(section, atIndex: 0)
            }

            self.context?.notify(.Newer)
        }
    }

    func loadOlder() {
        if isThereOngoingRequest {
            return
        }

        var daysAgo = 0

        if let section = content.last {
            daysAgo = formatter.daysAgo(fromDateAsString: section.day) + 1
        }

        getPostsPosted(daysAgo) { (section) in
            if let section = section {
                self.content.append(section)
            }

            self.context?.notify(.Older)
        }
    }

    func todayPosts() -> [PHPost]? {
        guard let section = content.first else  {
            return nil
        }

        return section.posts
    }

    private func getPostsPosted(daysAgo: Int, completion: PHFetcherCompletion) {
        getPostsPosted(daysAgo, retries: 20, completion: completion)
    }

    private func getPostsPosted(daysAgo: Int, retries: Int, completion: PHFetcherCompletion) {
        if retries == 0 {
            isThereOngoingRequest = false
            completion(section: nil)
            return
        }

        isThereOngoingRequest = true

        PHAPI.sharedInstance.getPosts(daysAgo) { (posts, error) in
            self.isThereOngoingRequest = false

            if let posts = posts where posts.count > 0 {
                completion(section: PHSection(day: posts.first!.day, posts: posts ))
            } else {
                self.getPostsPosted(daysAgo + 1, retries: retries - 1, completion: completion)
            }
        }
    }
}