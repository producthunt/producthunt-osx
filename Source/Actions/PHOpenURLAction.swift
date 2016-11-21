//
//  PHOpenURLAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/16/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHOpenURLAction {

    class func perform(withPath path: String, closeAfterLaunch: Bool = false) {
        perform(withUrl: URL(string: path)!, closeAfterLaunch: closeAfterLaunch)
    }

    class func perform(withUrl url: URL, closeAfterLaunch: Bool = false) {
        let handle = NSWorkspace.shared().open(url)

        if handle && closeAfterLaunch {
            PHPopoverAction.close()
        }
    }
}
