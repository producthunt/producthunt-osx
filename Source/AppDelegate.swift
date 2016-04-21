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

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let popover = NSPopover()

    var settingsWindow = PHPreferencesWindowController()
    var countdownToMarkAsSeen: NSTimer?

    private(set) var statusBarUpdater: PHStatusBarUpdater!
    private var updatePostTimer: NSTimer?

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
            PHUserDefaults.registerDefaults()
            PHStartAtLoginAction.perform(true)
            
            SUUpdater.sharedUpdater().automaticallyChecksForUpdates = true
            SUUpdater.sharedUpdater().automaticallyDownloadsUpdates = false
        }

        statusBarUpdater = PHStatusBarUpdater(button: statusItem.button)
        PHAppContext.sharedInstance.addObserver(statusBarUpdater)

        PHAppContext.sharedInstance.fetcher.loadNewer()

        updatePostTimer = NSTimer.every(10.minutes) {
            PHAppContext.sharedInstance.fetcher.loadNewer()
        }

        NSApp.registerForRemoteNotificationTypes(.Alert)

        SUUpdater.sharedUpdater().feedURL = NSURL(string: kPHFeedUrl)!
        SUUpdater.sharedUpdater().updateCheckInterval = 60 * 60 * 24
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

