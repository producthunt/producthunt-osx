//
//  NSColor+ProductHunt.swift
//  ProductHunt
//
//  Created by Vlado on 3/24/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

extension NSColor {

    class func ph_whiteColor() -> NSColor {
        return NSColor.white
    }

    class func ph_highlightColor() -> NSColor {
        return NSColor(calibratedRed: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }

    class func ph_orangeColor() -> NSColor {
        return NSColor(calibratedRed: 228/255, green: 81/255, blue: 39/255, alpha: 1)
    }

    class func ph_grayColor() -> NSColor {
        return NSColor(calibratedRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }

    class func ph_lightGrayColor() -> NSColor {
        return NSColor(calibratedRed: 204/255, green: 204/255, blue: 208/255, alpha: 1)
    }
}
