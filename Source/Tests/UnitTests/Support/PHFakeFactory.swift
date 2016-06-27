//
//  PHFakeFactory.swift
//  ProductHunt
//
//  Created by Vlado on 3/31/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHFakeFactory {

    static let sharedInstance = PHFakeFactory()

    private var fakePostId = 0

    func token() -> PHToken {
        return PHToken(accessToken: "FakeToken")
    }

    func post(daysAgo: NSTimeInterval = 0.days, votes: Int = 20, commentsCount: Int = 0) -> PHPost {
        let id          = fakePostId
        let title       = "Title \(fakePostId)"
        let tagline     = "Tagline \(fakePostId)"
        let url         = NSURL(string: "https//example.com/\(fakePostId)")!
        let day         = daysAgoAsString(daysAgo)
        let redirectUrl = NSURL(string: "https//example.com/\(fakePostId)")!
        
        defer {
            fakePostId += 1
        }

        return PHPost(id: id,title: title, tagline: tagline, thumbnailUrl: url, discussionUrl: url, day: day, votesCount: votes, commentsCount: commentsCount, createdAt: createdAt(), redirectUrl: redirectUrl)
    }

    private func daysAgoAsString(days: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSinceNow: -days)

        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        return dateformatter.stringFromDate(date)
    }

    private func createdAt() -> String {
        let formatter = NSDateFormatter()

        formatter.timeZone = NSTimeZone(abbreviation: "PSD")

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        return formatter.stringFromDate(NSDate())
    }

}