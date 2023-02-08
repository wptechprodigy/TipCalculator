//
//  MainViewController.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitTipInputView = SplitTipInputView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitTipInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let viewModel = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.bg
        layoutSubviews()
        bind()
        observe()
    }
    
    private func bind() {
        let input = CalculatorViewModel
            .Input(
                billPublisher: billInputView.valuePublisher,
                tipPublisher: tipInputView.valuePublisher,
                splitPublisher: splitTipInputView.valuePublisher,
                logoViewTapPublisher: logoViewTapPublisher)
        let output = viewModel.transform(input: input)
        
        output
            .updateViewPublisher
            .sink { [unowned self] result in
                resultView.configure(with: result)
            }
            .store(in: &cancellables)
        
        output
            .resultCalculatorPublisher
            .sink { _ in
                print("The tap is passed into the VM...")
            }
            .store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher
            .sink { [unowned self] _ in
                view.endEditing(true)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    
    private func layoutSubviews() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+16+56)
        }
        
        splitTipInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}
