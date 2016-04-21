//
//  PHLoadingView.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

protocol PHLoadingViewDelegate {
    func reload()
}

enum LoadingState {
    case Loading, Error, Empty, Idle
}

class PHLoadingView: NSView {

    var delegate: PHLoadingViewDelegate?

    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet weak var loadingLabel: NSTextField!
    @IBOutlet weak var reload: PHButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }

    func showState(state: LoadingState) {
        switch state {
        case .Loading:
            hidden = false
            reload.hidden = true
            loadingIndicator.hidden = false
            loadingIndicator.startAnimation(nil)
            loadingLabel.stringValue = "Hunting down new posts..."

        case .Error:
            hidden = false
            reload.hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            loadingLabel.stringValue = "Something went wrong 😿"

        case .Empty:
            hidden = false
            reload.hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            loadingLabel.stringValue = "Nothing to show 😿"

        case .Idle:
            hidden = true
            loadingIndicator.stopAnimation(nil)
        }
    }

    @IBAction func toggleReloadButton(sender: NSView) {
        showState(.Loading)
        delegate?.reload()
    }
}
