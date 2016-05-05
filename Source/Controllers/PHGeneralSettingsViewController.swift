//
//  PHGeneralSettingsViewController.swift
//  ProductHunt
//
//  Created by Vlado on 3/22/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import ServiceManagement
import ReSwift

class PHGeneralSettingsViewController: NSViewController, PHPreferencesWindowControllerProtocol, StoreSubscriber {

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

        filterVotesSlider.minValue = 0
        filterVotesSlider.maxValue = 100

        versionLabel.stringValue = "Product Hunt for OSX \(PHBundle.version())"

        store.subscribe(self)

        newState(store.state)
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        store.unsubscribe(self)
    }

    @IBAction func startAtLoginAction(sender: NSButton) {
        store.dispatch( PHSettingsActionAutoLogin(autologin: sender.boolState) )
    }

    @IBAction func showPostsCountAction(sender: NSButton) {
        store.dispatch( PHSettingsActionShowsCount(showsCount: sender.boolState) )
    }

    @IBAction func filterSliderValueChanged(sender: NSSlider) {
        store.dispatch( PHSettngsActionFilterCount(filterCount: currenSliderValue) )
    }

    func newState(state: PHAppState) {
        startAtLoginButton.setState(forBool: state.settings.autologinEnabled)
        showsCountButton.setState(forBool: state.settings.showsCount)

        filterVotesSlider.integerValue = state.settings.filterCount

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
