//
//  PHGeneralSettingsViewController.swift
//  ProductHunt
//
//  Created by Vlado on 3/22/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import ServiceManagement

class PHGeneralSettingsViewController: NSViewController, PHPreferencesWindowControllerProtocol {

    @IBOutlet weak var startAtLoginButton: NSButton!
    @IBOutlet weak var showsCountButton: NSButton!
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var filterVotesLabel: NSTextField!
    @IBOutlet weak var filterVotesSlider: NSSlider!

    var currenSliderValue: Int {
        return Int(5 * Int(round(filterVotesSlider.floatValue / 5.0)))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()

        startAtLoginButton.setState(forBool: PHUserDefaults.getAutoLogin())
        showsCountButton.setState(forBool: PHUserDefaults.getShowsCount())

        filterVotesSlider.minValue = 0
        filterVotesSlider.maxValue = 100

        filterVotesSlider.integerValue = PHUserDefaults.getFilterCount()

        versionLabel.stringValue = "Product Hunt for OSX \(PHBundle.version())"

        updateUI()
    }

    @IBAction func startAtLoginAction(sender: NSButton) {
        let startAtLogin = sender.boolState

        PHUserDefaults.setAutoLogin(startAtLogin)
        PHStartAtLoginAction.perform(startAtLogin)
    }

    @IBAction func showPostsCountAction(sender: NSButton) {
        let showsCount = sender.boolState
        PHUserDefaults.setShowsCount(showsCount)

        PHAppContext.sharedInstance.notify(.Newer)
    }

    @IBAction func filterSliderValueChanged(sender: NSSlider) {
        PHUserDefaults.setFilterCount(currenSliderValue)
        PHAppContext.sharedInstance.notify(.Newer)
        updateUI()
    }

    private func updateUI() {
        filterVotesLabel.stringValue = currenSliderValue == 0 ? "Don't filter out posts by votes" : "Filter out posts with less than \(currenSliderValue) votes"
    }

    // MARK: PHPreferencesWindowControllerProtocol

    func preferencesIdentifier() -> String {
        return "PHGeneralSettingsViewControllerIdentifier"
    }

    func preferencesTitle() -> String {
        return "General"
    }

    func preferencesIcon() -> NSImage {
        return NSImage(named: NSImageNamePreferencesGeneral)!
    }
}
