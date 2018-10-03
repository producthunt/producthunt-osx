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

let store = Store<PHAppState>(reducer: appReducer, state: nil, middleware: [PHTrackingMiddleware])

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()

    var settingsWindow = PHPreferencesWindowController()
    var countdownToMarkAsSeen: Timer?

    fileprivate var statusBarUpdater: PHStatusBarUpdater!
    fileprivate var updatePostTimer: Timer?
    fileprivate let defaults = PHDefaults(store: store)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.imagePosition = .imageLeft
            button.action = #selector(togglePopover)
        }

        popover.contentViewController = PHPostListViewController(nibName: "PHPostListViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearance.Name.aqua)
        popover.animates = false
        popover.behavior = .transient

        PHFirstLaunchAction.perform {
            PHStartAtLoginAction.perform(true)
            
            SUUpdater.shared().automaticallyChecksForUpdates = true
            SUUpdater.shared().automaticallyDownloadsUpdates = false
        }

        statusBarUpdater = PHStatusBarUpdater(button: statusItem.button, store: store)

        PHLoadPostOperation.performNewer()

        updatePostTimer = Timer.every(10.minutes) {
            PHLoadPostOperation.performNewer()
        }

        SUUpdater.shared().feedURL = URL(string: kPHFeedUrl)!
        SUUpdater.shared().updateCheckInterval = 1.day
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        updatePostTimer?.invalidate()
        updatePostTimer = nil
    }

    // MARK: Actions

    @objc func togglePopover() {
        PHPopoverAction.toggle()
    }

    @objc func openAppsLink() {
        PHOpenProductHuntAction.performWithAppsLink()
    }

    @objc func openFAQLink() {
        PHOpenProductHuntAction.performWithFAQLink()
    }

    @objc func openAboutLink() {
        PHOpenProductHuntAction.performWithAboutLink()
    }

    @objc func showSettings() {
        PHOpenSettingsAction.perform()
        PHPopoverAction.close()
    }

    @objc func quit() {
        NSApplication.shared.terminate(self)
    }

    @objc func checkForUpdates() {
        SUUpdater.shared().checkForUpdates(nil)
    }
}

