//
//  DateComponentsFormatter.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation

extension DateComponentsFormatter{
    static let abbreviated: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter .abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    static let positional: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter .positional")
        let formatter = DateComponentsFormatter ()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
