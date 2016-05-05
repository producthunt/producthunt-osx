//
//  PHAPICallMiddleware.swift
//  Product Hunt
//
//  Created by Vlado on 5/4/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

let PHTrackingMiddleware: Middleware = { dispatch, getState in
    return { next in
        return { action in

            // TODO: Implement tracking

            return next(action)
        }
    }
}