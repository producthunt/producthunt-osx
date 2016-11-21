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

    fileprivate let manager = AFHTTPSessionManager(baseURL: URL(string: "\(kPHAnalitycsEndpointHost)/v1"))

    init(key: String) {
        manager.responseSerializer  = AFJSONResponseSerializer()
        manager.requestSerializer   = AFJSONRequestSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        manager.requestSerializer.setValue(Credentials.basic(key, password: ""), forHTTPHeaderField: "Authorization")
    }

    func get(_ url: String, parameters: [String: Any]?, completion: PHAPIEndpointCompletion? = nil) {
        manager.get(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion?((response as? [String: AnyObject]), nil)
        }) { (task, error) in
            print(error)
            completion?(nil, error as NSError?)
        }
    }

    func post(_ url: String, parameters: [String: Any]?, completion: PHAPIEndpointCompletion? = nil) {
        manager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion?((response as? [String: AnyObject]), nil)
        }) { (task, error) in
            print(error)
            completion?(nil, error as NSError?)
        }
    }

}
