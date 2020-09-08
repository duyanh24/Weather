//
//  Converter.swift
//  Weather
//
//  Created by Apple on 9/7/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

class Converter {
    static func convertKelvinToCencius(kelvin: Double) -> Int {
        return Int(kelvin - 273)
    }
    
    static func convertDurationTimeToHour(durationTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(durationTime - 18000))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.init(forSecondsFromGMT: 0) as TimeZone
        formatter.dateFormat = "HH"
        return formatter.string(from: date as Date)
    }
    
    static func convertDurationTimeToHourMinute(durationTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(durationTime - 18000))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.init(forSecondsFromGMT: 0) as TimeZone
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date as Date)
    }
    
    static func convertDurationTimeToWeekday(durationTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(durationTime))
        let formatter = DateFormatter()
        return formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date as Date) - 1]
    }
    
    static func convertDurationTimeToHourMinute2(durationTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(durationTime - 18000))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.init(forSecondsFromGMT: 0) as TimeZone
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date as Date)
    }
}
