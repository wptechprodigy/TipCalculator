//
//  CalculatorViewModel.swift
//  TipCalculator
//
//  Created by waheedCodes on 06/02/2023.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private let audioPlayerService: AudioPlayerService
    
    // MARK: - Input
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    // MARK: - Output
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resultCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    // MARK: - Initializer
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    // MARK: - Helpers
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
                input.billPublisher,
                input.tipPublisher,
                input.splitPublisher)
            .flatMap { [unowned self] bill, tip, split in
                let totalTip = getTipAmount(on: bill, with: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                
                return Just(result)
            }
            .eraseToAnyPublisher()
        
        let resultCalculatorPublisher = input
            .logoViewTapPublisher
            .handleEvents(receiveOutput:  { [unowned self] in
                audioPlayerService.playSound()
            }).flatMap({
                return Just(())
            })
            .eraseToAnyPublisher()
        
        return Output(
            updateViewPublisher: updateViewPublisher,
            resultCalculatorPublisher: resultCalculatorPublisher
        )
    }
    
    private func getTipAmount(on bill: Double, with tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
