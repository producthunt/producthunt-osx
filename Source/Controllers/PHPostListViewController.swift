//
//  PHPostListViewController.swift
//  ProductHunt
//
//  Created by Vlado on 3/14/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import DateTools
import SwiftyTimer

class PHPostListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, PHDataSourceDelegate, PHLoadingViewDelegate {

    @IBOutlet weak var productTableView: NSTableView!
    @IBOutlet weak var loadingView: PHLoadingView!
    @IBOutlet weak var lastUpdatedLabel: NSTextField!
    @IBOutlet weak var homeButton: PHButton!
    @IBOutlet weak var settingsButton: PHButton!

    private var updateUITimer: NSTimer?
    private var source = PHPostsDataSource(context: PHAppContext.sharedInstance)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.ph_whiteColor().CGColor

        productTableView.intercellSpacing = NSSize.zero

        source.delegate = self

        loadingView.delegate = self
        loadingView.showState(.Loading)

        homeButton.setImages("Icon-product-hunt", highlitedImage: "icon-kitty")

        updateUI()
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        updateUITimer = NSTimer.every(15.seconds) { [weak self] in self?.updateUI() }

        self.source.loadNewer()

        PHScheduleAsSeenAction.performCancel()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()

        if let timer = updateUITimer {
            timer.invalidate()
        }

        updateUITimer = nil

        PHScheduleAsSeenAction.performSchedule()
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return source.numberOfRows()
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        loadOlderIfNeeded(row)
        return PHSectionCell.view(tableView, owner: self, subject: source.data(atIndex: row)) ?? PHPostCell.view(tableView, owner: self, subject: source.data(atIndex: row))
    }

    func tableView(tableView: NSTableView, isGroupRow row: Int) -> Bool {
        return source.isGroup(atIndex: row)
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return source.isGroup(atIndex: row) ? 45 : tableView.rowHeight
    }

    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if let post = source.data(atIndex: row) as? PHPost {
            PHOpenPostAction.perform(withPost: post)
            updateUI()
        }

        return true
    }

    private func loadOlderIfNeeded(row: Int) {
        if source.numberOfRows()-row < 15 {
            source.loadOlder()
        }
    }

    // MARK: PHDataSourceDelegate

    func contentChanged(updateType: UpdateType)  {
        if updateType == .Newer {
            PHUserDefaults.setLastUpdated()
        }

        let state = source.numberOfRows() > 0 ? LoadingState.Idle : LoadingState.Empty
        loadingView.showState(state)

        updateUI()
        productTableView.reloadData()
    }

    // MARK: PHLoadingViewDelegate

    func reload() {
        source.loadNewer()
    }

    // MARK: Actions

    @IBAction func toggleProductHuntButton(sender: AnyObject) {
        PHOpenURLAction.perform(withPath: "https://producthunt.com", closeAfterLaunch: true)
    }

    @IBAction func toggleSettingsButton(sender: NSView) {
        PHOpenSettingsMenuAction.perform(sender)
    }

    func updateUI() {
        lastUpdatedLabel.stringValue = "Last Updated: \(PHUserDefaults.getLastUpdated().timeAgoSinceNow())"
    }
}
