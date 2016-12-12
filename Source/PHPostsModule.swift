//
//  PHPostsModule.swift
//  Product Hunt
//
//  Created by Vlado on 4/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

struct PHPostsLoadAction: Action {
    var posts: [PHPost]
}

func postsReducer(_ action: Action, state: PHAppStatePosts?) -> PHAppStatePosts {
    let state = state ?? PHAppStatePosts(sections: [], lastUpdated: Date())

    switch action {
        case let action as PHPostsLoadAction:
            if action.posts.isEmpty {
                return state
            }

            let section = PHSection.section(action.posts)

            var newSections = state.sections
            var newLastUpdated = state.lastUpdated

            if PHDateFormatter.daysAgo(section.day) == 0 {
                if let firstSection = newSections.first, firstSection.day == section.day {
                    newSections[0] = section
                } else {
                    newSections.insert(section, at: 0)
                }

                newLastUpdated = Date()
            } else {
                newSections.append(PHSection.section(action.posts))
            }

            return PHAppStatePosts(sections: newSections, lastUpdated: newLastUpdated)

        default:
            return state
    }
}
