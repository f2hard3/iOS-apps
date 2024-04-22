//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit
import SnapKit
import Combine

class TipInputView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        tipSubject.eraseToAnyPublisher()
    }
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func observe() {
        tipSubject.sink { tip in
            self.resetView()
            
            switch tip {
            case .none:
                break
            case .tenPercent:
                self.tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .firteenPercent:
                self.fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                self.twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom:
                self.customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: tip.stringValue,
                    attributes: [.font: ThemeFont.bold(ofSize: 20) ]
                )
                text.addAttributes(
                    [.font: ThemeFont.bold(ofSize: 14)],
                    range: NSMakeRange(0, 1)
                )
                self.customTipButton.setAttributedTitle(text, for: .normal)
            }
        }
        .store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach { button in
            button.backgroundColor = ThemeColor.primary
            
            let text = NSAttributedString(
                string: "Custom tip",
                attributes: [.font: ThemeFont.bold(ofSize: 20) ]
            )
            customTipButton.setAttributedTitle(text, for: .normal)
        }
    }
    
    private let headerView: HeaderView = {
        let headerView = HeaderView(topText: "Choose", bottomText: "your tip")
        
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        button.tapPublisher.flatMap {
            Just(Tip.tenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .firteenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        button.tapPublisher.flatMap {
            Just(Tip.firteenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tweentyPercentButton.rawValue
        button.tapPublisher.flatMap {
            Just(Tip.twentyPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        button.tapPublisher.sink {
            self.handleCutomTipButton()
        }
        .store(in: &cancellables)
        
        return button
    }()
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor(.white)
            ]
        )
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        
        return button
    }
    
    private func handleCutomTipButton() {
        let alertController: UIAlertController = {
           let controller = UIAlertController(
            title: "Enter custom tip",
            message: nil,
            preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
            }
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default) { _ in
                    guard let text = controller.textFields?.first?.text,
                          let value = Int(text) else { return }
                    self.tipSubject.value = .custom(value: value)
                }
            
            [okAction, cancelAction].forEach(controller.addAction)
            
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton,
        ])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton,
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview)
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonHStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
}
