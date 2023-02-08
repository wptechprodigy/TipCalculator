//
//  Double+CurrencyFormat.swift
//  TipCalculator
//
//  Created by waheedCodes on 08/02/2023.
//

import Foundation

extension Double {
    private func currencyFormatter(isWholeNumber: Bool) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter
    }
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        
        return currencyFormatter(isWholeNumber: isWholeNumber)
            .string(for: self) ?? ""
    }
}
