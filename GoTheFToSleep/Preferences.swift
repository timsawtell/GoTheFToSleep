//
//  Preferences.swift
//  GoTheFToSleep
//
//  Created by Tim Sawtell on 14/03/2016.
//  Copyright © 2016 Tim Sawtell. All rights reserved.
//

import Foundation

enum stateEnum {
    case unknown
    case asleep
    case awake
}

class Preferences {
    var state = stateEnum.unknown
    var sleepHour, sleepMinute, wakeHour, wakeMinute: Int?
    
    func populateFromDefaults() {
        var wakeTimeValue = wakeTime()
        if wakeTimeValue == nil {
            wakeTimeValue = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(6, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0))!;
            setWakeTime(wakeTimeValue!)
        } else {
            wakeMinute = wakeTimeValue?.minute()
            wakeHour = wakeTimeValue?.hour()
        }
        
        var sleepTimeValue = sleepTime()
        if sleepTimeValue == nil {
            sleepTimeValue = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(19, minute: 30, second: 0, ofDate: NSDate(), options: NSCalendarOptions(rawValue:0))!;
            setSleepTime(sleepTimeValue!)
        } else {
            sleepMinute = sleepTimeValue?.minute()
            sleepHour = sleepTimeValue?.hour()
        }
    }
    
    func setWakeTime(date: NSDate) {
        NSUserDefaults.standardUserDefaults().setObject(date, forKey: "wakeTime")
        wakeHour = date.hour()
        wakeMinute = date.minute()
    }
    
    func wakeTime() -> NSDate? {
        if let time = NSUserDefaults.standardUserDefaults().objectForKey("wakeTime") as? NSDate {
            return time
        }

        return nil
    }
    
    func setSleepTime(date: NSDate) {
        NSUserDefaults.standardUserDefaults().setObject(date, forKey: "sleepTime")
        sleepMinute = date.minute()
        sleepHour = date.hour()
    }
    
    func sleepTime() -> NSDate? {
        if let time = NSUserDefaults.standardUserDefaults().objectForKey("sleepTime") as? NSDate {
            return time
        }
        
        return nil
    }
    
    func updateWithNewDate(date: NSDate) {
        let newMinute = date.minute()
        let newHour = date.hour()
        
        state = .awake
        if newHour > sleepHour {
            state = .asleep
        } else if newHour >= sleepHour && newMinute >= sleepMinute {
            state = .asleep
        } else if newHour < wakeHour {
            state = .asleep
        } else if newHour <= wakeHour && newMinute <= wakeMinute {
            state = .asleep
        }
    }
}
