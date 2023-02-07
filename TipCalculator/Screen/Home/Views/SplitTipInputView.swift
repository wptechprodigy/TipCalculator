//
//  SplitTipInputView.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit
import Combine
import CombineCocoa

class SplitTipInputView: UIView {
    
    // MARK: - Observers
    
    private var cancellables = Set<AnyCancellable>()
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    // MARK: - Properties
    
    private let headerView: HeaderView = {
        return HeaderView(
            topText: "Split",
            bottomText: "the total")
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            withTitle: "-",
            corners: [
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ])
        button
            .tapPublisher
            .flatMap { [unowned self] _ in
                Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
            }
            .assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        return LabelFactory
            .make(
                with: "1",
                font: ThemeFont.bold(ofSize: 20),
                backgroundColor: .white)
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            withTitle: "+",
            corners: [
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner
            ])
        button
            .tapPublisher
            .flatMap { [unowned self] _ in
                Just(splitSubject.value + 1)
            }
            .assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        sv.axis = .horizontal
        sv.spacing = 0
        return sv
    }()

    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func buildButton(
        withTitle title: String,
        corners: CACornerMask
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addSpecificRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
    
    // MARK: - Configuration
    
    private func observe() {
        splitSubject
            .sink { [unowned self] quantity in
                quantityLabel.text = quantity.stringValue
            }
            .store(in: &cancellables)
    }
    
    private func layout() {
        [headerView, hStackView].forEach(addSubview(_:))
        
        hStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
}
