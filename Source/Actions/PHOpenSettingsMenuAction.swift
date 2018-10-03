//
//  PHShowSettingsMenuAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHOpenSettingsMenuAction {

    class func perform(_ sender: NSView) {
        let delegate = NSApplication.shared.delegate as! AppDelegate

        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Apps", action: #selector(delegate.openAppsLink), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "FAQ", action: #selector(delegate.openFAQLink), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "About", action: #selector(delegate.openAboutLink), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Check for Updates", action: #selector(delegate.checkForUpdates), keyEquivalent: "u"))
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(delegate.showSettings), keyEquivalent: "s"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(delegate.quit), keyEquivalent: "q"))

        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender)
    }
}
