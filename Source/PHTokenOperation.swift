//
//  PHTokenOperation.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

// TODO: Remove if not needed
class PHTokenOperation {

    class func perform() {
        perform(store, api: PHAPI.sharedInstance)
    }

    class func perform(store: Store<PHAppState>, api: PHAPI) {
        api.getToken { (token, error) in
            guard let token = token else {
                return
            }

            store.dispatch( PHTokenGetAction(token: token) )
        }
    }
}