//
//  PHHardware.swift
//  ProductHunt
//
//  Created by Vlado on 3/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHBundle {

    class func shortVersion() -> String {
        return getValueFromInfoDictionary("CFBundleShortVersionString", subjectType: String()) ?? ""
    }

    class func version() -> String {
        return getValueFromInfoDictionary("CFBundleVersion", subjectType: String()) ?? ""
    }

    private class func getValueFromInfoDictionary<T>(key: String, subjectType: T) -> T? {
        guard let infoDictionary = NSBundle.mainBundle().infoDictionary else {
            return nil
        }

        return infoDictionary[key] as? T
    }
}