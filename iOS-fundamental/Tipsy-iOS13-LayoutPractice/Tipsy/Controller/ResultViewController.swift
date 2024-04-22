import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var result: Float = 0.0
    var split = 2
    var tipPct = "10%"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let total = String(format: "%.2f", result)
        totalLabel.text = total
        settingsLabel.text = "Split between \(split) people, with \(tipPct)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
