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

    fileprivate var fakePostId = 0

    func token() -> PHToken {
        return PHToken(accessToken: "FakeToken")
    }

    func post(_ daysAgo: TimeInterval = 0.days, votes: Int = 20, commentsCount: Int = 0) -> PHPost {
        let id          = fakePostId
        let title       = "Title \(fakePostId)"
        let tagline     = "Tagline \(fakePostId)"
        let url         = URL(string: "https//example.com/\(fakePostId)")!
        let day         = daysAgoAsString(daysAgo)
        let redirectUrl = URL(string: "https//example.com/\(fakePostId)")!
        
        defer {
            fakePostId += 1
        }

        return PHPost(id: id,title: title, tagline: tagline, thumbnailUrl: url, discussionUrl: url, day: day, votesCount: votes, commentsCount: commentsCount, createdAt: createdAt(), redirectUrl: redirectUrl)
    }

    fileprivate func daysAgoAsString(_ days: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: -days)

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        return dateformatter.string(from: date)
    }

    fileprivate func createdAt() -> String {
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone(abbreviation: "PSD")

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        return formatter.string(from: Date())
    }

}
