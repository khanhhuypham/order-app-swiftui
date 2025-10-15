//
//  Date + extension.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import UIKit


extension Date {
    
//    func adding(hour: Int) -> Date {
//        return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
//    }

    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
      
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }

    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }

    func isSmallerThanOrEqual(_ date: Date) -> Bool {
        return self <= date
    }
    
    
}

extension Date {
    func adding (_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
