//
//  UIView+LocalCurrencySymbol.swift
//  TipCalculator
//
//  Created by waheedCodes on 08/02/2023.
//

import UIKit

extension UIView {
    var localCurrencySymbol: String {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!

        return currencySymbol
    }
}
