//
//  PHPopoverAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHPopoverAction {

    fileprivate class var appDelegate: AppDelegate {
        return NSApplication.shared().delegate as! AppDelegate
    }

    class func toggle() {
        if appDelegate.popover.isShown {
            close()
        } else {
            show()
        }
    }

    class func close() {
        if !appDelegate.popover.isShown {
            return
        }

        appDelegate.popover.close()
    }

    class func show() {
        NSRunningApplication.current().activate(options: NSApplicationActivationOptions.activateIgnoringOtherApps)

        guard let button = appDelegate.statusItem.button else {
            return
        }

        appDelegate.popover.show(relativeTo: button.frame, of: button, preferredEdge: .minY)
    }
}
