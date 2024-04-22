//
//  HeaderView.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    init(topText: String, bottomText: String) {
        self.topLabel.text = topText
        self.bottomLabel.text = bottomText
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        
        return stackView
    }()
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
    }
}
