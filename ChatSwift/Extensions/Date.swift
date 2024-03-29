//
//  Date.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 18/01/2024.
//

import Foundation

extension Date {
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }
    
    func timsStampString() -> String {
        if Calendar.current.isDateInToday(self){
            return timeString()
        }
        else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        }
        else {
            return dateString()
        }
    }
}
