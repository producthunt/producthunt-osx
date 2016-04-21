//
//  PHAPI.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHAPICompletion       = ((token: PHToken?, error: NSError?) -> ())
typealias PHAPIPostCompletion   = ((posts: [PHPost]?, error: NSError?) -> ())

class PHAPI {

    static let sharedInstance = PHAPI()

    var endpoint = PHAPIEndpoint()

    func getToken(completion: PHAPICompletion) {
        let params = ["client_id" : kPHAppID, "client_secret": kPHAppSecret, "grant_type": "client_credentials"]

        endpoint.post("oauth/token", parameters: params) { (response, error) -> Void in
            completion(token: PHToken.token(fromDictionary: response), error: error)
        }
    }

    func getPosts(daysAgo: Int, completion: PHAPIPostCompletion) {
            getPosts(daysAgo, retries: 2, completion: completion)
    }

    private func getPosts(daysAgo: Int, retries: Int, completion: PHAPIPostCompletion) {
        if retries == 0 {
            completion(posts: nil, error: NSError.unauthorizedError())
            return
        }

        PHGetTokenAction.perform {
            self.endpoint.get("posts", parameters: ["days_ago": daysAgo, "search[category]": "all"]) { (response, error) -> Void in
                if let error = error where NSError.parseError(error) == NSError.unauthorizedError() {
                    PHKeychain.resetToken()
                    self.getPosts(daysAgo, retries: retries-1, completion: completion)
                } else {
                    guard let response = response, let rawPosts = response["posts"] as? [[String : AnyObject]] else {
                        completion(posts: nil, error: NSError.parseError(error))
                        return
                    }

                    completion(posts: PHPost.posts(fromArray: rawPosts) ?? [PHPost](), error: nil)
                }
            }
        }
    }

}
