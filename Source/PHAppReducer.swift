//
//  PHAppReducer.swift
//  Product Hunt
//
//  Created by Vlado on 4/27/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: PHAppState?) -> PHAppState {
    return PHAppState(
        settings: settingsReducer(action, state: state?.settings),
        posts: postsReducer(action, state: state?.posts),
        seenPosts: seenPostsReducer(action, state: state?.seenPosts),
        token: tokenReducer(action, state: state?.token)
    )
}
