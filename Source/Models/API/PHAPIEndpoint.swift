//
//  PHAPIEndpoint.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import AFNetworking

typealias PHAPIEndpointCompletion = (_ response: [String: Any]?, _ error: NSError?) -> Void

class PHAPIEndpoint {

    static let kPHEndpointHost = "https://api.producthunt.com"

    fileprivate let manager = AFHTTPSessionManager(baseURL: URL(string: "\(kPHEndpointHost)/v1"))

    init(token: PHToken?) {
        manager.responseSerializer  = AFJSONResponseSerializer()
        manager.requestSerializer   = AFJSONRequestSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = token {
            manager.requestSerializer.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
    }

    func get(_ url: String, parameters: [String: Any]?, completion: @escaping PHAPIEndpointCompletion) {
        manager.get(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion((response as? [String: AnyObject]), nil)
            }) { (task, error) in
                print(error)
                completion(nil, error as NSError?)
        }
    }

    func post(_ url: String, parameters: [String: Any]?, completion: @escaping PHAPIEndpointCompletion) {
        manager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
            completion((response as? [String: AnyObject]), nil)
            }) { (task, error) in
                print(error)
                completion(nil, error as NSError?)
        }
    }
}
