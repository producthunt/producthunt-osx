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

    class func perform(store: Store<PHAppState>, api: PHAPI, operation: PHAPIOperationClosure) {
        withToken(store, api: api) { (token, error) in
            operation(api: api, errorClosure: { (error) in
                if NSError.parseError(error) == NSError.unauthorizedError() {
                    let token = PHToken(accessToken: "", expirationDate: NSDate(timeIntervalSince1970: 0))
                    store.dispatch( PHTokenGetAction(token: token) )
                }

                withToken(store, api: api, callback: { (token, error) in
                    operation(api: api, errorClosure: { (error) in
                        //TODO : Dispatch errror
                    })
                })
            })
        }
    }

    private class func withToken(store: Store<PHAppState>, api: PHAPI, callback: PHAPITokenCompletion) {
        if store.state.token.isValid {
            callback(token: store.state.token, error: nil)
            return
        }

        api.getToken { (token, error) in
            if let token = token {
                // TODO: Other mechanism to update token

                api.endpoint = PHAPIEndpoint(token: token)
                store.dispatch( PHTokenGetAction(token: token) )
            }

            callback(token: token, error: error)
        }
    }
}