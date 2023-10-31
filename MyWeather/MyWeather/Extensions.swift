//
//  Extensions.swift
//  MyWeather
//
//  Created by Erberk Yaman on 23.10.2023.
//

import Foundation



extension Double {
    static func convertFahrenheitToCelsius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
    
    var fahrenheitToCelsius: Double {
        return (self - 32) * 5/9
    }
    
    var firstThreeDigits: String {
        // Convert the Double to a String
        let stringValue = String(format: "%.2f", self)
        
        // Use prefix to get the first 3 digits (including the decimal point)
        let firstThree = stringValue.prefix(4)
        
        return String(firstThree)
    }
}
