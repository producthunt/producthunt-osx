//
//  PHButton.swift
//  ProductHunt
//
//  Created by Vlado on 3/24/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHButton: NSButton {

    private let cursor = NSCursor.pointingHandCursor()
    private var normalStateImage: NSImage?
    private var highlightedStateImage: NSImage?
    private var trackingArea: NSTrackingArea?

    override func resetCursorRects() {
        addCursorRect(bounds, cursor: cursor)
        cursor.set()
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    func commonInit() {
    }

    func setImages(normalImage: String, highlitedImage: String) {
        self.setButtonType(.MomentaryChangeButton)

        normalStateImage = NSImage(named: normalImage)
        highlightedStateImage = NSImage(named: highlitedImage)
    }

    func resetTrackingArea() {
        trackingArea = nil

        if let normalStateImage = normalStateImage {
            image = normalStateImage
        }
    }

    private func createTrackingAreaIfNeeded() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: CGRect.zero, options: [.InVisibleRect, .MouseEnteredAndExited, .ActiveAlways], owner: self, userInfo: nil)
        }
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        createTrackingAreaIfNeeded()

        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }

    override func mouseEntered(theEvent: NSEvent) {
        if let highlightedImage = highlightedStateImage {
            image = highlightedImage
        }
    }

    override func mouseExited(theEvent: NSEvent) {
        if let normalStateImage = normalStateImage {
            image = normalStateImage
        }
    }
}
