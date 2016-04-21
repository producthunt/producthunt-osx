//
//  NSButton+ProductHunt.swift
//  Product Hunt
//
//  Created by Vlado on 4/18/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

extension NSButton {

    var boolState: Bool {
        return state == 1 ? true : false
    }

    func setState(forBool bool: Bool) {
        state = bool ? 1 : 0
    }
}