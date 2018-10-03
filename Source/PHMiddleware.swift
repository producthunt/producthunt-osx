//
//  PHAPICallMiddleware.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

let PHTrackingMiddleware: Middleware<PHAppState> = { dispatch, getState in
    return { next in
        return { action in

            if let action = action as? PHTrackPostAction {
                PHAnalitycs.sharedInstance.trackClickPost(action.post.id)
            }

            if let action = action as? PHTrackPostShare {
                PHAnalitycs.sharedInstance.trackShare("post", subjectId: action.post.id, medium: action.medium)
            }

            if let action = action as? PHTrackVisit {
                PHAnalitycs.sharedInstance.trackVisit(action.page)
            }

            return next(action)
        }
    }
}
