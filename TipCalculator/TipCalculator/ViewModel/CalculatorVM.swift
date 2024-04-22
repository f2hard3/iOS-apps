//
//  CalculatorVM.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/16.
//

import Foundation
import Combine

class CalculatorVM {
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    private let audioPlayerService: AudioPlayerService
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(input.billPublisher, input.tipPublisher, input.splitPublisher)
            .flatMap { (bill, tip, split) in
                let totalTip = self.getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / split.doubleValue
                
                let result = Result(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip
                )
                
                return Just(result)
            }
            .eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input
            .logoViewTapPublisher
            .handleEvents(receiveOutput: {
                self.audioPlayerService.playSound()
            }).flatMap {
                Just($0)
            }.eraseToAnyPublisher()
        
        return Output(
            updateViewPublisher: updateViewPublisher,
            resetCalculatorPublisher: resetCalculatorPublisher
        )
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .firteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .custom(let value):
            return value.doubleValue
        }
    }
}
