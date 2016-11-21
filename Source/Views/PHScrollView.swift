//
//  PHTableView.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHScrollView: NSScrollView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let layer = CALayer()
        layer.borderColor = NSColor.windowBackgroundColor.cgColor
        layer.borderWidth = 1
        layer.frame = NSRect(x: 0, y: dirtyRect.size.height - 1, width: dirtyRect.size.width, height: 1)

        self.layer?.addSublayer(layer)
    }
}
