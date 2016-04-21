//
//  PHPopoverAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHPopoverAction {

    private class var appDelegate: AppDelegate {
        return NSApplication.sharedApplication().delegate as! AppDelegate
    }

    class func toggle() {
        if appDelegate.popover.shown {
            close()
        } else {
            show()
        }
    }

    class func close() {
        if !appDelegate.popover.shown {
            return
        }

        appDelegate.popover.close()
    }

    class func show() {
        NSRunningApplication.currentApplication().activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)

        guard let button = appDelegate.statusItem.button else {
            return
        }

        appDelegate.popover.showRelativeToRect(button.frame, ofView: button, preferredEdge: .MinY)
    }
}