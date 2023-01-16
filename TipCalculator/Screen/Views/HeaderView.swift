//
//  HeaderView.swift
//  TipCalculator
//
//  Created by waheedCodes on 16/01/2023.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func layout() {
        backgroundColor = .systemRed
    }
}
