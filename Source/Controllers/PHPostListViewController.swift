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

class PHPostListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, PHDataSourceDelegate {

    @IBOutlet weak var productTableView: NSTableView!
    @IBOutlet weak var loadingView: PHLoadingView!
    @IBOutlet weak var lastUpdatedLabel: NSTextField!
    @IBOutlet weak var homeButton: PHButton!
    @IBOutlet weak var settingsButton: PHButton!

    fileprivate var source = PHPostsDataSource(store: store)
    fileprivate var updateUITimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true

        view.layer?.backgroundColor = NSColor.ph_whiteColor().cgColor

        productTableView.intercellSpacing = NSSize.zero

        source.delegate = self

        loadingView.state = .loading

        homeButton.setImages("Icon-product-hunt", highlitedImage: "icon-kitty")
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        self.source.loadNewer()

        PHScheduleAsSeenAction.performCancel()

        updateUITimer = Timer.every(15.seconds) { [weak self] in self?.updateUI() }

        updateUI()

        PHAnalitycsOperation.performTrackVisit("home")
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()

        PHScheduleAsSeenAction.performSchedule()

        if let timer = updateUITimer {
            timer.invalidate()
        }

        updateUITimer = nil
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return source.numberOfRows()
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        loadOlderIfNeeded(row)
        return PHSectionCell.view(tableView, owner: self, subject: source.data(atIndex: row)) ?? PHPostCell.view(tableView, owner: self, subject: source.data(atIndex: row))
    }

    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
        return source.isGroup(atIndex: row)
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return source.isGroup(atIndex: row) ? 45 : tableView.rowHeight
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if let post = source.data(atIndex: row) as? PHPost {
            PHOpenPostOperation.perform(withPost: post)
        }

        return true
    }

    fileprivate func loadOlderIfNeeded(_ row: Int) {
        if source.numberOfRows()-row < 15 {
            source.loadOlder()
        }
    }

    // MARK: PHDataSourceDelegate

    func contentChanged()  {
        loadingView.state = source.numberOfRows() > 0 ? .idle : .empty

        productTableView.reloadData()

        updateUI()
    }

    // MARK: Actions

    @IBAction func toggleProductHuntButton(_ sender: AnyObject) {
        PHOpenURLAction.perform(withPath: "https://producthunt.com", closeAfterLaunch: true)
    }

    @IBAction func toggleSettingsButton(_ sender: NSView) {
        PHOpenSettingsMenuAction.perform(sender)
    }

    func updateUI() {
        if let lastUpdated = (store.state.posts.lastUpdated as NSDate).timeAgoSinceNow() {
            lastUpdatedLabel.stringValue = "Last Updated: \(lastUpdated)"
        }
    }
}
