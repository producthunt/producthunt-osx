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
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.string(from: Date())

        let formattedString = formatter.format(withDateString: dateAsString)!

        XCTAssertTrue(formattedString.range(of: "Today") != nil)
    }

    func testThatItFormatsYesterday() {
        let date = Date(timeIntervalSinceNow: -(60*60*24 + 1))

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.string(from: date)

        let formattedString = formatter.format(withDateString: dateAsString)!

        XCTAssertTrue(formattedString.range(of: "Yesterday") != nil)
    }

    func testThatAddsStSuffux() {
        let dateString = "2016-01-31"

        let formattedString = formatter.format(withDateString: dateString)!

        XCTAssertTrue(formattedString.range(of: "31st") != nil)
    }

    func testThatAddsRdSuffix() {
        let dateString = "2016-01-03"
        
        let formattedString = formatter.format(withDateString: dateString)!

        XCTAssertTrue(formattedString.range(of: "3rd") != nil)
    }

    func testThatHandlesInvalidDate() {
        let date = "wrong date"

        XCTAssertNil(formatter.format(withDateString: date))
    }

    func testThatItReturnsDaysAgo() {
        let date = Date(timeIntervalSinceNow: -1.day)

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"

        let dateAsString = dateformatter.string(from: date)

        XCTAssertEqual(formatter.daysAgo(fromDateAsString: dateAsString), 1)
    }
}
