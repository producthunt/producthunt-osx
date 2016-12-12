//
//  PHFirstLaunchAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/22/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHFirstLaunchAction {

    class func perform(_ completion: PHVoidCallback) {
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: "alreadyLaunched") {

            completion()

            defaults.set(true, forKey: "alreadyLaunched")
            defaults.synchronize()
        }
    }
}
