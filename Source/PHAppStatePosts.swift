//
//  PHAppStatePosts.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

struct PHAppStatePosts {

    var sections: [PHSection]

    var today: Int {
        return 0
    }

    var nextDay: Int {
        guard let section = sections.last else  {
            return 0
        }

        return PHDateFormatter.daysAgo(section.day) + 1
    }

    var todayPosts: [PHPost]?  {
        guard let section = sections.first else  {
            return nil
        }

        return section.posts
    }

    var lastUpdated: Date
}
