//
//  PHAnalitycsAPIEndpoint.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import AFNetworking

class PHAnalitycsAPIEndpoint {

    static let kPHAnalitycsEndpointHost = "https://api.segment.io"

    private let manager = AFHTTPSessionManager(baseURL: NSURL(string: "\(kPHAnalitycsEndpointHost)/v1"))

    init(key: String) {
        manager.responseSerializer  = AFJSONResponseSerializer()
        manager.requestSerializer   = AFJSONRequestSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        manager.requestSerializer.setValue(Credentials.basic(key, password: ""), forHTTPHeaderField: "Authorization")
    }

    func get(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion? = nil) {
        manager.GET(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion?(response: (response as? [String: AnyObject]), error: nil)
        }) { (task, error) in
            print(error)
            completion?(response: nil, error: error)
        }
    }

    func post(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion? = nil) {
        manager.POST(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion?(response: (response as? [String: AnyObject]), error: nil)
        }) { (task, error) in
            print(error)
            completion?(response: nil, error: error)
        }
    }

}