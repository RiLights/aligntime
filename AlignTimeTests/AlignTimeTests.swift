//
//  AlignTimeTests.swift
//  AlignTimeTests
//
//  Created by Ostap on 3/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import XCTest
@testable import AlignTime

class AlignTimeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_days_left() {
        let align_time:AlignTime = AlignTime()
        do {
            try align_time.update_today_dates()
        } catch {}

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "219")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
