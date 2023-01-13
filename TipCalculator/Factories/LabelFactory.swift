//
//  LabelFactory.swift
//  TipCalculator
//
//  Created by waheedCodes on 12/01/2023.
//

import UIKit

struct LabelFactory {
    
    static func make(with text: String?, font: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = ThemeColor.text, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
