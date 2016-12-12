//
//  PHSectionNew.swift
//  ProductHunt
//
//  Created by Vlado on 3/29/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

struct PHSection {

    static func section(_ posts: [PHPost]) -> PHSection {
        return PHSection(day: posts.first!.day, posts: posts)
    }

    var day: String
    var posts: [PHPost]

}
