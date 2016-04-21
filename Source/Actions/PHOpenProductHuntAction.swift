//
//  PHOpenProductHuntAction.swift
//  Product Hunt
//
//  Created by Vlado on 4/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHOpenProductHuntAction: NSObject {

    class func performWithFAQLink() {
        PHOpenURLAction.perform(withPath: "https://www.producthunt.com/faq", closeAfterLaunch: true)
    }

    class func performWithAboutLink() {
        PHOpenURLAction.perform(withPath: "https://www.producthunt.com/about", closeAfterLaunch: true)
    }

    class func performWithAppsLink() {
        PHOpenURLAction.perform(withPath: "https://www.producthunt.com/apps", closeAfterLaunch: true)
    }
}