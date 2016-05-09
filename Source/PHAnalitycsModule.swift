//
//  PHAnalitycsModule.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import ReSwift

struct PHTrackPostAction: Action {
    var post: PHPost
}

struct PHTrackPostShare: Action {
    var post: PHPost
    var medium: String
}

struct PHTrackVisit: Action {
    var page: String
}