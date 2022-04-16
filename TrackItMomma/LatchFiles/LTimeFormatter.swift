//
//  LTimeFormatter.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import Foundation

struct LTimeFormatter {
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        
        let dateString = formatter.string(from: Date())
        return dateString
    }

    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat    = "MMM d, EEEE"
        
        let dateString = formatter.string(from: Date())
        print(dateString)
        return dateString
    }

    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        guard let time1 = timeformatter.date(from: time1Str),
              let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        //You can directly use from here if you have two dates
        
        let interval = time2.timeIntervalSince(time1)
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        return "\(Int(minute))"
    }
}
