//
//  HeaderView.swift
//  TipCalculator
//
//  Created by waheedCodes on 16/01/2023.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    private let topText: String
    private let bottomText: String
    
    private lazy var topTextLabel: UILabel = {
        return LabelFactory
            .make(with: topText, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private lazy var bottomTextLabel: UILabel = {
        return LabelFactory
            .make(with: bottomText, font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            topSpacerView,
            topTextLabel,
            bottomTextLabel,
            bottomSpacerView
        ])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = -4
        return sv
    }()
    
    // MARK: - Initializers
    
    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
    }
}
