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

func postsReducer(action: Action, state: PHAppStatePosts?) -> PHAppStatePosts {
    let state = state ?? PHAppStatePosts(sections: [], lastUpdated: NSDate())

    switch action {
        case let action as PHPostsLoadAction:
            if action.posts.isEmpty {
                return state
            }

            let section = PHSection.section(action.posts)

            var newSections = state.sections
            var newLastUpdated = state.lastUpdated

            if PHDateFormatter.daysAgo(section.day) == 0 {
                if let firstSection = newSections.first where firstSection.day == section.day {
                    newSections[0] = section
                } else {
                    newSections.insert(section, atIndex: 0)
                }

                newLastUpdated = NSDate()
            } else {
                newSections.append(PHSection.section(action.posts))
            }

            return PHAppStatePosts(sections: newSections, lastUpdated: newLastUpdated)

        default:
            return state
    }
}