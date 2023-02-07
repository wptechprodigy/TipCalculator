//
//  UIResponder+ParentController.swift
//  TipCalculator
//
//  Created by waheedCodes on 07/02/2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
