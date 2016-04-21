//
//  PHSeenView.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHSeenView: NSView {

    override func awakeFromNib() {
        super.awakeFromNib()

        wantsLayer = true
        layer?.backgroundColor = NSColor.ph_orangeColor().CGColor
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        layer?.cornerRadius = dirtyRect.size.height/2
    }
}
