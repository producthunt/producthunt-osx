//
//  PHAPIEndpoint.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import AFNetworking

typealias PHAPIEndpointCompletion = (response: [String: AnyObject]?, error: NSError?) -> Void

class PHAPIEndpoint {

    static let kPHEndpointHost = "https://api.producthunt.com"

    private let manager = AFHTTPSessionManager(baseURL: NSURL(string: "\(kPHEndpointHost)/v1"))

    init(token: PHToken?) {
        manager.responseSerializer  = AFJSONResponseSerializer()
        manager.requestSerializer   = AFJSONRequestSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = token {
            manager.requestSerializer.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
    }

    func get(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion) {
        manager.GET(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion(response: (response as? [String: AnyObject]), error: nil)
            }) { (task, error) in
                print(error)
                completion(response: nil, error: error)
        }
    }

    func post(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion) {
        manager.POST(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion(response: (response as? [String: AnyObject]), error: nil)
            }) { (task, error) in
                print(error)
                completion(response: nil, error: error)
        }
    }
}