import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmi?.getBMIValue()
        adviceLabel.text = bmi?.advice
        self.view.backgroundColor = bmi?.color ?? UIColor.white
    }
    

    @IBAction func recalculatePressed( _ sender: UIButton) {
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
