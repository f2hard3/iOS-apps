//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let splitSubject = CurrentValueSubject<Int, Never>(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    private func observe() {
        splitSubject.sink { quantity in
            self.quantityLabel.text = quantity.stringValue
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        splitSubject.send(1)
    }
    
    private let headerView = {
       return HeaderView(topText: "Split", bottomText: "the total")
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            text: "-",
            corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        )
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButton.rawValue
        button.tapPublisher.flatMap {
            Just(
                self.splitSubject.value == 1
                ? 1
                : self.splitSubject.value - 1
            )
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        )
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
        button.tapPublisher.flatMap {
            return Just(self.splitSubject.value + 1)
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        
        return button
    }()
        
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addRoundedCorners(corners: corners, radius: 8.0)
        
        return button
    }    
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            backgroundColor: .white
        )
        label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
        
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        return stackView
    }()
    
    private func layout() {
        [headerView, hStackView].forEach(addSubview)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [decrementButton, incrementButton].forEach { button in
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

