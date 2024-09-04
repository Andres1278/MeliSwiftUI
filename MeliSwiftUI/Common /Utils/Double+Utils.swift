//
//  Double+Utils.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 1/09/24.
//

import Foundation

extension Double {
    
    func toCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = .zero
        return formatter.string(from: NSNumber(value: self))!
    }
}
