//
//  NSDateExtension.swift
//  MiltonMobileIOS
//
//  Created by Jacob Aronoff on 11/4/15.
//  Copyright © 2015 Milton Academy. All rights reserved.
//

import Foundation

enum Weekday: Int {
    case Monday=1, Tuesday, Wednesday, Thursday, Friday, Saturday
}

extension NSDate {
    struct Calendar {
        static let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    }
    func following1(weekday weekday: Weekday) -> NSDate {
        let components = NSDateComponents()
        components.weekday = weekday.rawValue
        guard
            let date = Calendar.gregorian.nextDateAfterDate(self, matchingComponents: components, options: .MatchNextTime)
            else { return NSDate.distantFuture() }
        //print(date)
        return  date
    }
    func following(weekday weekday: Weekday) -> NSDate{
        let calendar = NSCalendar.currentCalendar()
        let currentDateComponents = calendar.components([.YearForWeekOfYear, .WeekOfYear ], fromDate: NSDate())
        let startOfWeek = calendar.dateFromComponents(currentDateComponents)
        let nextDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: weekday.rawValue,
            toDate: startOfWeek!,
            options: NSCalendarOptions(rawValue: 0))
        return nextDate!
    }
}

