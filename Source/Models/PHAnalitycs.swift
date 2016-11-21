//
//  PHAnalitycs.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHAnalitycsProperties = [String: Any]

class PHAnalitycs {

    static let sharedInstance = PHAnalitycs()

    fileprivate let kTrackEventVisit    = "visit"
    fileprivate let kTrackEventClick    = "click"
    fileprivate let kTrackEventShare    = "share"
    fileprivate let kTrackPlatform      = "osx"

    fileprivate var api = PHAnalitycsAPI()

    fileprivate var context: PHAnalitycsProperties {
        return [ "uuid"  : PHBundle.systemUUID() as AnyObject ]
    }

    fileprivate var timestamp: String {
        return (Date() as NSDate).iso8601String() ?? ""
    }

    func trackClickPost(_ id: Int)  {
        trackClick("post", subjectId: id)
    }

    func trackClick(_ subjectType: String, subjectId: Int) {
        let properties: PHAnalitycsProperties = [
            "event"     : kTrackEventClick,
            "properties": [
                "subject_type"          : subjectType,
                "subject_id"            : subjectId,
                "platform"              : kTrackPlatform,
                "page"                  : "home",
                "deeplink_uri_pattern"  : "/home",
                "deeplink_uri_full"     : "/home",
            ],
            "context"   : context,
            "timestamp" : timestamp
        ]

        api.track(properties)
    }

    func trackShare(_ subjectType: String, subjectId: Int, medium: String) {
        let properties: PHAnalitycsProperties = [
            "event"     : kTrackEventShare,
            "properties": [
                "subject_type"          : subjectType,
                "subject_id"            : subjectId,
                "platform"              : kTrackPlatform,
                "medium"                : medium,
                "page"                  : "home",
                "deeplink_uri_pattern"  : "/home",
                "deeplink_uri_full"     : "/home",
            ],
            "context"   : context,
            "timestamp" : timestamp
        ]

        api.track(properties)
    }

    func trackVisit(_ page: String) {
        let properties: PHAnalitycsProperties = [
            "event"     : kTrackEventVisit as AnyObject,
            "page"      : page as AnyObject,
            "timestamp" : timestamp as AnyObject
        ]

        api.visit(properties)
    }
}
