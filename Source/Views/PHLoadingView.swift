//
//  PHLoadingView.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

enum LoadingState {
    case loading, error, empty, idle
}

class PHLoadingView: NSView {

    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet weak var loadingLabel: NSTextField!
    @IBOutlet weak var reload: PHButton!

    var state: LoadingState = .idle {
        didSet {
            switch state {
            case .loading:
                isHidden = false
                reload.isHidden = true
                loadingIndicator.isHidden = false
                loadingIndicator.startAnimation(nil)
                loadingLabel.stringValue = "Hunting down new posts..."

            case .error:
                isHidden = false
                reload.isHidden = false
                loadingIndicator.isHidden = true
                loadingIndicator.stopAnimation(nil)
                loadingLabel.stringValue = "Something went wrong 😿"

            case .empty:
                isHidden = false
                reload.isHidden = false
                loadingIndicator.isHidden = true
                loadingIndicator.stopAnimation(nil)
                loadingLabel.stringValue = "Nothing to show 😿"

            case .idle:
                isHidden = true
                loadingIndicator.stopAnimation(nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }

    @IBAction func toggleReloadButton(_ sender: NSView) {
        state = .loading
        PHLoadPostOperation.performNewer()
    }
}
