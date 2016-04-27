//
//  AppDelegate.swift
//  Product Hunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import SwiftyTimer
import Sparkle
import ReSwift

let store = Store<PHAppState>(reducer: PHAppReducer(), state: nil, middleware: [PHTrackingMiddleware])

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let popover = NSPopover()

    var settingsWindow = PHPreferencesWindowController()
    var countdownToMarkAsSeen: NSTimer?

    private var statusBarUpdater: PHStatusBarUpdater!
    private var updatePostTimer: NSTimer?
    private let defaults = PHDefaults()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.imagePosition = .ImageLeft
            button.action = #selector(togglePopover)
        }

        popover.contentViewController = PHPostListViewController(nibName: "PHPostListViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        popover.animates = false
        popover.behavior = .Transient

        PHFirstLaunchAction.perform {
            PHStartAtLoginAction.perform(true)
            
            SUUpdater.sharedUpdater().automaticallyChecksForUpdates = true
            SUUpdater.sharedUpdater().automaticallyDownloadsUpdates = false
        }

        statusBarUpdater = PHStatusBarUpdater(button: statusItem.button, store: store)

        PHLoadPostOperation.performNewer()

        updatePostTimer = NSTimer.every(10.minutes) {
            PHLoadPostOperation.performNewer()
        }

        SUUpdater.sharedUpdater().feedURL = NSURL(string: kPHFeedUrl)!
        SUUpdater.sharedUpdater().updateCheckInterval = 1.day
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        updatePostTimer?.invalidate()
        updatePostTimer = nil
    }

    // MARK: Actions

    func togglePopover() {
        PHPopoverAction.toggle()
    }

    func openAppsLink() {
        PHOpenProductHuntAction.performWithAppsLink()
    }

    func openFAQLink() {
        PHOpenProductHuntAction.performWithFAQLink()
    }

    func openAboutLink() {
        PHOpenProductHuntAction.performWithAboutLink()
    }

    func showSettings() {
        PHOpenSettingsAction.perform()
        PHPopoverAction.close()
    }

    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }

    func checkForUpdates() {
        SUUpdater.sharedUpdater().checkForUpdates(nil)
    }
}

