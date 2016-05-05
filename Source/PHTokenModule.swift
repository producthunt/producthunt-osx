//
//  PHTokenModule.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

struct PHTokenGetAction: Action {
    var token: PHToken
}

func tokenReducer(action: Action, state: PHToken?) -> PHToken {
    let state = state ?? PHToken(accessToken: "", expirationDate: NSDate(timeIntervalSince1970: 0) )

    switch action {
        case let action as PHTokenGetAction:
            return action.token

        default:
            return state
    }
}
