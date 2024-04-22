//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        billSubject.eraseToAnyPublisher()
    }
    
    private func observe() {
        textField.textPublisher.sink { text in
            self.billSubject.send(text?.douleValue ?? 0)
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        textField.text = nil
        billSubject.send(0)
    }
    
    private let headerView: HeaderView = {
       return HeaderView(topText: "Enter", bottomText: "your bill")
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        
        return view
    }()
    
    private let currenctDenominationLabel: UILabel = {
        let label =  LabelFactory.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 24)
        )
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        textField.accessibilityIdentifier = ScreenIdentifier.BillInputView.textField.rawValue
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        return textField
    }()
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
    
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview)
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)            
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [currenctDenominationLabel, textField].forEach(textFieldContainerView.addSubview)
        
        currenctDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currenctDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
}

