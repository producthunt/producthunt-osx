//
//  PHFirstLaunchAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/22/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHFirstLaunchAction {

    class func perform(completion: PHVoidCallback) {
        if !PHUserDefaults.getAlreadyLaunched() {
            
            completion()

            PHUserDefaults.setAlreadyLaunched(true)
        }
    }
}