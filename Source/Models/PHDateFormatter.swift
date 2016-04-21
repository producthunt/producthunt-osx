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

    private let formatter = NSDateFormatter()
    private var units: [Int : String] {
        return [0: "th", 1: "st", 21: "st", 31: "st", 2: "nd", 22: "nd", 3: "rd", 23: "rd"]
    }

    func format(withDateString dateString: String) -> String? {
        guard let date = parseDate(dateString) else {
            return nil
        }

        return format(date)
    }

    func format(date: NSDate) -> String {
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
        var timeZone = NSTimeZone(abbreviation: "PST")
        guard let date = NSDate(ISO8601String: dateString, timeZone: &timeZone, usingCalendar: nil) else {
            return ""
        }

        return date.shortTimeAgoSinceNow()
    }

    private func parseDate(dateAsString: String) -> NSDate? {
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.dateFromString(dateAsString) else {
            return nil
        }

        return date
    }

    private func daysAgo(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: date, toDate: NSDate(), options: []).day
    }

    private func getDayName(date: NSDate) -> String {
        formatter.dateFormat = "EEEE"

        switch daysAgo(date) {
        case 0  : return "Today"
        case 1  : return "Yesterday"
        default : return self.formatter.stringFromDate(date)
        }
    }

    private func getMonthName(date: NSDate) -> String {
        formatter.dateFormat = "MMMM"
        return self.formatter.stringFromDate(date)
    }

    private func getDaySuffix(date: NSDate) -> String {
        let day = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: date)
        let unit = units[day] ?? units[0]

        return "\(day)\(unit!)"
    }
}