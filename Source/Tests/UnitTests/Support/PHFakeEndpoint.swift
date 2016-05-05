//
//  PHFakeEndpoint.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

struct PHTestFakeAPIEndpointStub {

    var method: String
    var url: String
    var parameters: [String : AnyObject]
    var response: [String : AnyObject]?
    var error: NSError?

    func match(method: String, url: String, parameters: [String : AnyObject]) -> Bool {
        return self.method == method && self.url == url && self.parameters.description == parameters.description
    }
}

class PHAPIFakeEndpoint: PHAPIEndpoint {

    private var fakes = [PHTestFakeAPIEndpointStub]()

    override init(token: PHToken?) {
        super.init(token: token)
    }

    func addFake(method: String, url: String, parameters: [String: AnyObject], response: [String: AnyObject]?, error: NSError?)  {
        let stub = PHTestFakeAPIEndpointStub(method: method, url: url, parameters: parameters, response: response, error: error)
        fakes.append(stub)
    }

    override func get(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion) {
        handleFakeMethod("GET", url: url, parameters: parameters ?? [String: AnyObject](), completion: completion)
    }

    override func post(url: String, parameters: [String: AnyObject]?, completion: PHAPIEndpointCompletion) {
        handleFakeMethod("POST", url: url, parameters: parameters ?? [String: AnyObject](), completion: completion)
    }

    private func handleFakeMethod(method: String, url: String, parameters: [String : AnyObject], completion: PHAPIEndpointCompletion) {
        guard let stub = fakes.filter({ $0.match(method, url: url, parameters: parameters) }).first else {
            NSException(name: "PHTestFakeAPIEndpoingFailure", reason: "No response found for \(method) \(url) (\(parameters.description))", userInfo: nil).raise()
            return
        }

        completion(response: stub.response, error: stub.error)
    }
}