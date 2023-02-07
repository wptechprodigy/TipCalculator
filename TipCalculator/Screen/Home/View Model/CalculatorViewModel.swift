//
//  CalculatorViewModel.swift
//  TipCalculator
//
//  Created by waheedCodes on 06/02/2023.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    // MARK: - Output
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    // MARK: - Helper
    
    func transform(input: Input) -> Output {
        
        input
            .tipPublisher
            .sink { tip in
                print(">>> The tip is \(tip)")
            }
            .store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 50,
            totalBill: 150,
            totalTip: 20)
        
        return Output(
            updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
