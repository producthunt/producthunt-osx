//
//  PHDateFormatter.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import DateTools
import ISO8601

class PHDateFormatter {

    class func daysAgo(_ dateString: String) -> Int {
        return PHDateFormatter().daysAgo(fromDateAsString: dateString)
    }

    fileprivate let formatter = DateFormatter()
    fileprivate var units: [Int : String] {
        return [0: "th", 1: "st", 21: "st", 31: "st", 2: "nd", 22: "nd", 3: "rd", 23: "rd"]
    }

    func format(withDateString dateString: String) -> String? {
        guard let date = parseDate(dateString) else {
            return nil
        }

        return format(date)
    }

    func format(_ date: Date) -> String {
        let day     = getDayName(date)
        let month   = getMonthName(date)
        let suffix  = getDaySuffix(date)

        return "\(day), \(month) \(suffix)"
    }

    func daysAgo(fromDateAsString dateString: String) -> Int {
        guard let date = parseDate(dateString) else {
            return 0
        }

        return daysAgo(date)
    }

    func timeAgo(fromDateAsString dateString: String) -> String {
        guard var timeZone = NSTimeZone(abbreviation: "PST"), let date = NSDate(iso8601String: dateString, timeZone: &timeZone, using: nil) else {
            return ""
        }

        return date.shortTimeAgoSinceNow()
    }

    fileprivate func parseDate(_ dateAsString: String) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(from: dateAsString) else {
            return nil
        }

        return date
    }

    fileprivate func daysAgo(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: date, to: Date(), options: []).day!
    }

    fileprivate func getDayName(_ date: Date) -> String {
        formatter.dateFormat = "EEEE"

        switch daysAgo(date) {
        case 0  : return "Today"
        case 1  : return "Yesterday"
        default : return self.formatter.string(from: date)
        }
    }

    fileprivate func getMonthName(_ date: Date) -> String {
        formatter.dateFormat = "MMMM"
        return self.formatter.string(from: date)
    }

    fileprivate func getDaySuffix(_ date: Date) -> String {
        let day = (Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: date)
        let unit = units[day] ?? units[0]

        return "\(day)\(unit!)"
    }
}
