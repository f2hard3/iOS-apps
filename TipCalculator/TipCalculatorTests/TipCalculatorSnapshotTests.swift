//
//  TipCalculatorSnapshotTests.swift
//  TipCalculatorTests
//
//  Created by Sunggon Park on 2024/04/18.
//

import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTests: XCTestCase {
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoVIew() {
        // given
        let size = CGSize(width: screenWidth, height: 48)
        
        // when
        let view = LogoView()
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        // given
        let size = CGSize(width: screenWidth, height: 224)
        
        // when
        let view = ResultView()
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testresultViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 224)
        
        // when
        let view = ResultView()
        view.configure(
            result: .init(
                amountPerPerson: 130,
                totalBill: 260,
                totalTip: 60)
        )
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
       
    func testInitialBillInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = BillInputView()
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testbillInputViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        
        // when
        let view = TipInputView()
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        // given
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        
        // when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = SplitInputView()
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
}
  
extension UIView {
    func allSubViewsOf<T: UIView>(type _: T.Type) -> [T] {
        var all = [T]()
        
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { view in
                getSubview(view: view)
            }
        }
        
        getSubview(view: self)
        
        return all
    }
}
