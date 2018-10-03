//
//  PHShowSettingsAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/21/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHOpenSettingsAction {

    class func perform() {
        let delegate = NSApplication.shared.delegate as! AppDelegate

        delegate.settingsWindow = PHPreferencesWindowController()
        delegate.settingsWindow.viewControllers = [ PHGeneralSettingsViewController(nibName: "PHGeneralSettingsViewController", bundle: nil), PHAdvancedSettingsViewController(nibName: "PHAdvancedSettingsViewController", bundle: nil) ]

        delegate.settingsWindow.showPreferencesWindow()
    }
}
