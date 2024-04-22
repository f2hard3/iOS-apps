//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by Sunggon Park on 2024/04/15.
//

import XCTest
import Combine
@testable import TipCalculator

final class TipCalculatorTests: XCTestCase {
    // sut: System Under Test
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    
    private var mockAudioPlayerService: MockAudioPlayerService!

    override func setUpWithError() throws {
        mockAudioPlayerService = .init()
        logoViewTapSubject = .init()
        sut = .init(audioPlayerService: mockAudioPlayerService)
        cancellables = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
        logoViewTapSubject = nil
        mockAudioPlayerService = nil
    }

    func testResultWithoutTipFor1Person() throws {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }
        .store(in: &cancellables)
    }
    
    func testResultWithoutTipFor2Person() throws {
        // given
        let bill: Double = 500
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 250)
            XCTAssertEqual(result.totalBill, 500)
            XCTAssertEqual(result.totalTip, 0)
        }
        .store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() throws {
        // given
        let bill: Double = 1500
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 825)
            XCTAssertEqual(result.totalBill, 1650)
            XCTAssertEqual(result.totalTip, 150)
        }
        .store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() throws {
        // given
        let bill: Double = 3640
        let tip: Tip = .custom(value: 450)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 1022.5)
            XCTAssertEqual(result.totalBill, 4090)
            XCTAssertEqual(result.totalTip, 450)
        }
        .store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
        // given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        
        // when
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        // then
        logoViewTapSubject.send()
        wait(for: [expectation1, mockAudioPlayerService.expectation], timeout: 1.0)
        
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

class MockAudioPlayerService: AudioPlayerService {
    let expectation = XCTestExpectation(description: "playsound is called")
    
    func playSound() {
        expectation.fulfill()
    }
}
