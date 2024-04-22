//
//  AmoutView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit

class AmountView: UIView {
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 24)]
        )
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private lazy var headerLabel = {
        return LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAlignment
        )
    }()
    
    private lazy var amountLabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(ofSize: 24)]
        )
        text.addAttributes([.font: ThemeFont.bold(ofSize: 12)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

