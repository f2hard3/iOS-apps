//
//  Button+Ext.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/09.
//

import Foundation
import SwiftUI

extension Button {
    func doneButton() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.brown)
            .foregroundStyle(.white)
    }
}
