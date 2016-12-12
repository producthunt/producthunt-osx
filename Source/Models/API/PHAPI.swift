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

    fileprivate(set) var isThereOngoingRequest = false

    func getToken(_ completion: @escaping PHAPITokenCompletion) {
        let params = ["client_id" : kPHAppID, "client_secret": kPHAppSecret, "grant_type": "client_credentials"]

        endpoint.post("oauth/token", parameters: params) { (response, error) -> Void in
            completion(PHToken.token(fromDictionary: response), error)
        }
    }

    func getPosts(_ daysAgo: Int, completion: @escaping PHAPIPostCompletion) {
        getPostsPosted(daysAgo, retries: 20, completion: completion)
    }

    fileprivate func getPostsPosted(_ daysAgo: Int, retries: Int, completion: @escaping PHAPIPostCompletion) {
        if retries == 0 {
            isThereOngoingRequest = false
            completion([], NSError.unauthorizedError())
            return
        }

        isThereOngoingRequest = true

        self.endpoint.get("posts", parameters: ["days_ago": daysAgo, "search[category]": "all"]) { (response, error) -> Void in
            self.isThereOngoingRequest = false

            if let response = response, let rawPosts = response["posts"] as? [[String : AnyObject]] {
                completion(PHPost.posts(fromArray: rawPosts), nil)
            } else if let error = error {
                completion([PHPost](), error)
            } else {
                self.getPostsPosted(daysAgo + 1, retries: retries - 1, completion: completion)
            }
        }
    }

}
