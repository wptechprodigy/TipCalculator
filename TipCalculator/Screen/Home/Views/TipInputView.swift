//
//  TipInputView.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    // MARK: - Properties
    
    private let headerView: HeaderView = {
        return HeaderView(
            topText: "Choose",
            bottomText: "your tip")
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button
            .tapPublisher
            .flatMap {
                Just(Tip.tenPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button
            .tapPublisher
            .flatMap {
                Just(Tip.fifteenPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button
            .tapPublisher
            .flatMap {
                Just(Tip.twentyPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Custom tip", for: .normal)
        button.addCornerRadius(ofSize: 8.0)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button
            .tapPublisher
            .sink { [weak self] _ in
                self?.didTapCustomTipButton()
            }
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var buttonTipsVStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            hStackView,
            customTipButton
        ])
        sv.axis = .vertical
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()

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
        [headerView, buttonTipsVStackView].forEach(addSubview(_:))
        
        buttonTipsVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(68)
            make.top.equalTo(buttonTipsVStackView).offset(10)
            make.trailing.equalTo(buttonTipsVStackView.snp.leading).offset(-24)
        }
    }
    
    // MARK: - Builder
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(ofSize: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    private func didTapCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter Custom Tip",
                message: nil,
                preferredStyle: .alert)
            
            controller.addTextField { textField in
                textField.placeholder = "Make it generous..."
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okAction = UIAlertAction(
                title: "OK",
                style: .default) { _ in
                    print(">>> Tip agreed on")
                }
            [cancelAction, okAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
}
