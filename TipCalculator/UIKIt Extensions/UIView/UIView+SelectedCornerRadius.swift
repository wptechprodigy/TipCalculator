//
//  UIView+SelectedCornerRadius.swift
//  TipCalculator
//
//  Created by waheedCodes on 21/01/2023.
//

import UIKit

extension UIView {
    
    func addSpecificRoundedCorners(
        corners: CACornerMask,
        radius: CGFloat) {
            layer.cornerRadius = radius
            layer.maskedCorners = [corners]
        }
}
