//
//  Date+WelcomeText.swift
//  Nike
//
//  Created by Александр Милейчик on 10/3/24.
//

import Foundation

extension Date {
    
    var welcomeText: String {
        
        let hour = Calendar.current.component(.hour, from: self)
        let greeting: String
        
        switch hour {
            
        case 5...11:
            greeting = "Good Morning"
        case 12...17:
            greeting = "Good Afternoon"
        case 18...23:
            greeting = "Good Evening"
        default:
            greeting = "Good Night"
        }
        
        return "\(greeting), Alexander"
    }
}
