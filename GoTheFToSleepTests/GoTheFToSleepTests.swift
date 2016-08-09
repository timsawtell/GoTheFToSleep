//
//  GoTheFToSleepTests.swift
//  GoTheFToSleepTests
//
//  Created by Tim Sawtell on 9/08/2016.
//  Copyright © 2016 Tim Sawtell. All rights reserved.
//

import XCTest
@testable import GoTheFToSleep

class GoTheFToSleepTests: XCTestCase {
    
    func testAwakeAndAsleep() {
        let preferences = Preferences()
        
        // Set the wake time
        if let sixAMDate = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(6, minute: 00, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.setWakeTime(sixAMDate)
        } else {
            XCTFail("Couldn't set wake time")
        }
        
        // Set the sleep time
        if let sevenPMDate = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(19, minute: 00, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.setSleepTime(sevenPMDate)
        } else {
            XCTFail("Couldn't set sleep time")
        }
        
        // Test the wake and sleep states
        if let sixThirtyAM = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(6, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.updateWithNewDate(sixThirtyAM)
            XCTAssertTrue(preferences.state == .awake)
        } else {
            XCTFail("Unable to test wake time")
        }
        
        if let fiveThirtyAM = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(5, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.updateWithNewDate(fiveThirtyAM)
            XCTAssertTrue(preferences.state == .asleep)
        } else {
            XCTFail("Unable to test sleep time")
        }
        
        if let sixThirtyPM = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(18, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.updateWithNewDate(sixThirtyPM)
            XCTAssertTrue(preferences.state == .awake)
        } else {
            XCTFail("Unable to test wake time")
        }
        
        if let sevenThirtyPM = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(19, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0)) {
            preferences.updateWithNewDate(sevenThirtyPM)
            XCTAssertTrue(preferences.state == .asleep)
        } else {
            XCTFail("Unable to test sleep time")
        } 
    }
    
}
