//
//  PHStartAtLoginAction.swift
//  ProductHunt
//
//  Created by Vlado on 3/22/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ServiceManagement

class PHStartAtLoginAction {

    class func perform(startAtLogin: Bool) {
        LLManager.setLaunchAtLogin(startAtLogin)
    }
}
