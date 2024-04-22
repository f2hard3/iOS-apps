//
//  ResultView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit

class ResultView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 48)]
        )
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private let headerLabel: UILabel = {
        return LabelFactory.build(text: "Total p/person", font: ThemeFont.bold(ofSize: 16))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(ofSize: 48)]
        )
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView,
        ])
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    private let totalBillView: AmountView = {
        AmountView(
            title: "Total bill",
            textAlignment: .left,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
    }()
    
    private let totalTipView: AmountView = {
        AmountView(
            title: "Total tip",
            textAlignment: .right,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func layout() {
        addSubview(vStackView)
        backgroundColor = .white
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 4),
            color: .black,
            radius: 12,
            opacity: 0.2
        )
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        
        return view
    }
}
