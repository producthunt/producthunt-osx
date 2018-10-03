//
//  NSImage+ProductHunt.swift
//  ProductHunt
//
//  Created by Vlado on 4/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

extension NSImage {

    func tintedImageWithColor(_ color: NSColor) -> NSImage {
        let tinted = self.copy() as! NSImage
        tinted.lockFocus()
        color.set()

        let imageRect = NSRect(origin: NSZeroPoint, size: self.size)
        __NSRectFillUsingOperation(imageRect, NSCompositingOperation.sourceAtop)

        tinted.unlockFocus()
        return tinted
    }
}
