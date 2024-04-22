//
//  CalculatorVC.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalculatorVC: UIViewController {
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private let vm = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
        observe()
    }
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }
        .eraseToAnyPublisher()
    }()
    
    private func observe() {
        viewTapPublisher.sink {
            self.view.endEditing(true)
        }
        .store(in: &cancellables)
    }
    
    private func bind() {
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher,
            logoViewTapPublisher: logoView.logoViewTapPublisher
        )
        
        let output = vm.transform(input: input)
        output.updateViewPublisher.sink { result in
            self.resultView.configure(result: result)
        }
        .store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { _ in
            self.billInputView.reset()
            self.tipInputView.reset()
            self.splitInputView.reset()
            
            UIView.animate(withDuration: 0.1) {
                self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logoView.transform = .identity
                }
            }
        }
        .store(in: &cancellables)
    }
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        
        return stackView
    }()
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp_leadingMargin).offset(16)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-16)
            make.top.equalTo(view.snp_topMargin).offset(16)
            make.bottom.equalTo(view.snp_bottomMargin).offset(-16)
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
            make.height.equalTo(56 + 56 + 16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}

