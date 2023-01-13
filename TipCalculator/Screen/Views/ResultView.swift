//
//  ResultView.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit

class ResultView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        LabelFactory
            .make(
                with: "Total p/person",
                font: ThemeFont.demiBold(ofSize: 16))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "$000",
            attributes: [ .font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 24)],
            range: NSMakeRange(0, 1))
        label.attributedText = text
        label.textAlignment = .center
        return label
    }()
    
    private let horizontalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            AmountView(),
            UIView(),
            AmountView()
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            amountPerPersonLabel,
            horizontalSeparatorView,
            buildSpacerView(ofHeight: 0),
            hStackView
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()

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
        backgroundColor = .white
        
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.leading.equalTo(snp.leading).offset(24)
        }
        
        horizontalSeparatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1)
    }
    
    private func buildSpacerView(ofHeight height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
