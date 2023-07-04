//
//  DateFormat.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

func formatDateString(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")
    inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
    outputFormatter.locale = Locale.current
    outputFormatter.timeZone = TimeZone.current
    
    if let date = inputFormatter.date(from: dateString) {
        return outputFormatter.string(from: date)
    }
    
    return nil
}
