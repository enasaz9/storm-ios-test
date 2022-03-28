//
//  StringExtension.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 28/03/2022.
//

import Foundation

// This extension to be used in manipulating the createdAt property in sorting and displaying.
extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return  dateFormatter.date(from: self) ?? Date()
    }
    
    func dateToFormattedString() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        let date: Date? = self.toDate()
        return dateFormatterPrint.string(from: date!);
    }
}
