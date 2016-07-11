//
//  PHLoadPostOperation.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

class PHLoadPostOperation {

    class func performNewer(store: Store<PHAppState>? = store) {
        guard let store = store else {
            return
        }

        perform(store, api: PHAPI.sharedInstance, daysAgo: store.state.posts.today)
    }

    class func performOlder(store: Store<PHAppState>? = store) {
        guard let store = store  else {
            return
        }

        perform(store, api: PHAPI.sharedInstance, daysAgo: store.state.posts.nextDay)
    }

    class func perform(app: Store<PHAppState>, api: PHAPI, daysAgo: Int) {
        if api.isThereOngoingRequest {
            return
        }

        let operation = createOperation(daysAgo) { (posts) in
            app.dispatch( PHPostsLoadAction(posts: posts) )
        }

        PHAPIOperation.perform(app, api: api, operation: operation)
    }

    class func createOperation(daysAgo: Int, complete: ([PHPost]) -> ()) -> PHAPIOperationClosure {
        return { (api: PHAPI, errorClosure: PHAPIErrorClosure) in
            api.getPosts(daysAgo, completion: { (posts, error) in
                if let error = error {
                    errorClosure(error: error)
                }

                complete(posts)
            })
        }
    }
}