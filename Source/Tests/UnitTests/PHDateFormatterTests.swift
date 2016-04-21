//
//  PHDateFormatter.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import XCTest

class PHDateFormatterTests: PHTestCase {

    let formatter = PHDateFormatter()

    func testThatItFormatsToday() {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.stringFromDate(NSDate())

        let formattedString = formatter.format(withDateString: dateAsString)!

        XCTAssertTrue(formattedString.rangeOfString("Today") != nil)
    }

    func testThatItFormatsYesterday() {
        let date = NSDate(timeIntervalSinceNow: -(60*60*24 + 1))

        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.stringFromDate(date)

        let formattedString = formatter.format(withDateString: dateAsString)!

        XCTAssertTrue(formattedString.rangeOfString("Yesterday") != nil)
    }

    func testThatAddsStSuffux() {
        let dateString = "2016-01-31"

        let formattedString = formatter.format(withDateString: dateString)!

        XCTAssertTrue(formattedString.rangeOfString("31st") != nil)
    }

    func testThatAddsRdSuffix() {
        let dateString = "2016-01-03"
        
        let formattedString = formatter.format(withDateString: dateString)!

        XCTAssertTrue(formattedString.rangeOfString("3rd") != nil)
    }

    func testThatHandlesInvalidDate() {
        let date = "wrong date"

        XCTAssertNil(formatter.format(withDateString: date))
    }

    func testThatItReturnsDaysAgo() {
        let date = NSDate(timeIntervalSinceNow: -1.day)

        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.stringFromDate(date)

        XCTAssertEqual(formatter.daysAgo(fromDateAsString: dateAsString), 1)
    }
}
