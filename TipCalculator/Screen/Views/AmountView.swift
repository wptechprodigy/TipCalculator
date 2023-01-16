//
//  AmountView.swift
//  TipCalculator
//
//  Created by waheedCodes on 13/01/2023.
//

import UIKit

class AmountView: UIView {
    
    // MARK: - Properties
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory
            .make(
                with: title,
                font: ThemeFont.regular(ofSize: 18),
                textColor: ThemeColor.text,
                textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "$000",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24),
                .foregroundColor: ThemeColor.primary
            ])
        text
            .addAttributes(
                [.font: ThemeFont.demiBold(ofSize: 16)],
                range: NSMakeRange(0, 1))
        label.attributedText = text
        label.textAlignment = textAlignment
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        sv.axis = .vertical
        sv.spacing = 2
        return sv
    }()

    // MARK: - Initializers
    
    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
