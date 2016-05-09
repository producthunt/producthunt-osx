//
//  PHAnalitycs.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

typealias PHAnalitycsProperties = [String: AnyObject]

class PHAnalitycs {

    static let sharedInstance = PHAnalitycs()

    private let kTrackEventVisit    = "visit"
    private let kTrackEventClick    = "click"
    private let kTrackEventShare    = "share"
    private let kTrackPlatform      = "osx"

    private var api = PHAnalitycsAPI()

    private var context: PHAnalitycsProperties {
        return [ "uuid"  : PHBundle.systemUUID() ]
    }

    private var timestamp: String {
        return NSDate().ISO8601String() ?? ""
    }

    func trackClickPost(id: Int)  {
        trackClick("post", subjectId: id)
    }

    func trackClick(subjectType: String, subjectId: Int) {
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

    func trackShare(subjectType: String, subjectId: Int, medium: String) {
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

    func trackVisit(page: String) {
        let properties: PHAnalitycsProperties = [
            "event"     : kTrackEventVisit,
            "page"      : page,
            "timestamp" : timestamp
        ]

        api.visit(properties)
    }
}