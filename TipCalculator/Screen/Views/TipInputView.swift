//
//  TipInputView.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit

class TipInputView: UIView {

    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func layout() {
        backgroundColor = .systemMint
    }
}
