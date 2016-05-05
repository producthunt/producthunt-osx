//
//  PHAPI.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHAPI {

    static let sharedInstance = PHAPI()

    var endpoint = PHAPIEndpoint(token: store.state.token)

    private(set) var isThereOngoingRequest = false

    func getToken(completion: PHAPITokenCompletion) {
        let params = ["client_id" : kPHAppID, "client_secret": kPHAppSecret, "grant_type": "client_credentials"]

        endpoint.post("oauth/token", parameters: params) { (response, error) -> Void in
            completion(token: PHToken.token(fromDictionary: response), error: error)
        }
    }

    func getPosts(daysAgo: Int, completion: PHAPIPostCompletion) {
        getPostsPosted(daysAgo, retries: 20, completion: completion)
    }

    private func getPostsPosted(daysAgo: Int, retries: Int, completion: PHAPIPostCompletion) {
        if retries == 0 {
            isThereOngoingRequest = false
            completion(posts: [], error: NSError.unauthorizedError())
            return
        }

        isThereOngoingRequest = true

        self.endpoint.get("posts", parameters: ["days_ago": daysAgo, "search[category]": "all"]) { (response, error) -> Void in
            self.isThereOngoingRequest = false

            if let response = response, let rawPosts = response["posts"] as? [[String : AnyObject]] {
                completion(posts: PHPost.posts(fromArray: rawPosts) ?? [PHPost](), error: nil)
            } else {
                self.getPostsPosted(daysAgo + 1, retries: retries - 1, completion: completion)
            }
        }
    }

}
