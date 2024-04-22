//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Sunggon Park on 2024/04/15.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {
    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = .init()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testResultViewDefaultValues() throws {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
    }
    
    func testRegularTip() {
      // User enters a $100 bill
      screen.enterBill(amount: 100)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$100")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$100")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    
      // User selects 10%
      screen.selectTip(tip: .tenPercent)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$110")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$110")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$10")

      // User selects 15%
      screen.selectTip(tip: .fifteenPercent)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$115")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$115")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$15")

      // User selects 20%
      screen.selectTip(tip: .twentyPercent)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$120")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$20")

      // User splits the bill by 4
      screen.selectIncrementButton(numberOfTaps: 3)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$30")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$20")

      // User splits the bill by 2
      screen.selectDecrementButton(numberOfTaps: 2)
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$60")
      XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
    }
    
    func testCustomTipAndSplitBillBy2() {
      screen.enterBill(amount: 300)
      screen.selectTip(tip: .custom(value: 200))
      screen.selectIncrementButton(numberOfTaps: 1)
      XCTAssertEqual(screen.totalBillValueLabel.label, "$500")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$200")
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$250")
    }
    
    func testResetButton() {
      screen.enterBill(amount: 300)
      screen.selectTip(tip: .custom(value: 200))
      screen.selectIncrementButton(numberOfTaps: 1)
      screen.doubleTapLogoView()
      XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
      XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
      XCTAssertEqual(screen.billInputViewTextField.label, "")
      XCTAssertEqual(screen.splitValueLabel.label, "1")
      XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }


//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
