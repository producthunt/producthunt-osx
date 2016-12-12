//
//  File.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

class PHAPIOperation {

    class func perform(_ store: Store<PHAppState>, api: PHAPI, operation: @escaping PHAPIOperationClosure) {
        withToken(store, api: api) { (token, error) in
            operation(api, { (error) in
                if NSError.parseError(error) == NSError.unauthorizedError() {
                    let token = PHToken(accessToken: "")
                    store.dispatch( PHTokenGetAction(token: token) )
                }

                withToken(store, api: api, callback: { (token, error) in
                    operation(api, { (error) in
                        //TODO : Dispatch errror
                    })
                })
            })
        }
    }

    fileprivate class func withToken(_ store: Store<PHAppState>, api: PHAPI, callback: @escaping PHAPITokenCompletion) {
        if store.state.token.isValid {
            callback(store.state.token, nil)
            return
        }

        api.getToken { (token, error) in
            if let token = token {
                // TODO: Other mechanism to update token

                api.endpoint = PHAPIEndpoint(token: token)
                store.dispatch( PHTokenGetAction(token: token) )
            }

            callback(token, error)
        }
    }
}
