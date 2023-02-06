//
//  MainViewController.swift
//  TipCalculator
//
//  Created by waheedCodes on 11/01/2023.
//

import UIKit
import SnapKit
import Combine

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

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.bg
        layoutSubviews()
        bind()
    }
    
    private func bind() {
        billInputView.valuePublisher.sink { bill in
            print(">>> The  bill is: \(bill)")
        }.store(in: &cancellables)
        
        let input = CalculatorViewModel
            .Input(
                billPublisher: billInputView.valuePublisher,
                tipPublisher: Just(.tenPercent).eraseToAnyPublisher(),
                splitPublisher: Just(3).eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output
            .updateViewPublisher
            .sink { result in
                print(">>> Result: \(result)")
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
