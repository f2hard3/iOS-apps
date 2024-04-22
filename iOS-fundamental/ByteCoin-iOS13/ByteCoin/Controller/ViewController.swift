import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }


}

// MARK: - UIPickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        currencyLabel.text = selectedCurrency
        
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

// MARK: - CoinManager
extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(_ price: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", price)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

