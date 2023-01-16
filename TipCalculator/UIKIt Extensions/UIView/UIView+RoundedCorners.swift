//
//  UIView+RoundedCorners.swift
//  TipCalculator
//
//  Created by waheedCodes on 16/01/2023.
//

import UIKit

extension UIView {
    
    func addCornerRadius(ofSize size: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = size
    }
}
