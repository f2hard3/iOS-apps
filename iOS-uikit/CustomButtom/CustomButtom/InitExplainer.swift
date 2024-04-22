//
//  InitExplainer.swift
//  CustomButtom
//
//  Created by Sunggon Park on 2024/03/22.
//

import Foundation

class Button {
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
}

class CustomButton: Button {
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
