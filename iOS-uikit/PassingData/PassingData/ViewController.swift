//
//  ViewController.swift
//  PassingData
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var delegateLabel: UILabel!
    @IBOutlet weak var closureLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notify) , name: Notification.Name("Notification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func notify(noti: Notification) {
        if let text = noti.userInfo?["message"] as? String {
            notificationLabel.text = text
        }
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        print(noti.userInfo!)
    }

    @IBAction func moveToDetail(_ sender: UIButton) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
//        detailVC.text = "From ViewController"
        
        self.present(detailVC, animated: true)
        
        detailVC.label.text = "From mainVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            guard let destinetaionVC = segue.destination as? SegueViewController else { return }
            destinetaionVC.text = "From mainVC"
            
//            segue.perform()
//            destinetaionVC.label.text = "From mainVC"
        }
     
    }
    
    @IBAction func moveToInstance(_ sender: UIButton) {
        let instanceVC = InstanceViewController(nibName: "InstanceViewController", bundle: nil)
        instanceVC.mainVC = self
        instanceVC.modalPresentationStyle = .fullScreen
        
        present(instanceVC, animated: true)
    }
    
    @IBAction func moveToDelegate(_ sender: UIButton) {
        let delegateVC = DelegateViewController(nibName: "DelegateViewController", bundle: nil)
        delegateVC.delegate = self
        present(delegateVC, animated: true)
    }
    
    @IBAction func moveToClosure(_ sender: UIButton) {
        let closureVC = ClosureViewController(nibName: "ClosureViewController", bundle: nil)
//        closureVC.closure = { string in
//            self.closureLabel.text = string
//        }
//        present(closureVC, animated: true)
        present(closureVC, animated: true) {
            closureVC.closure = { string in
                self.closureLabel.text = string
            }
        }
    }
    
    @IBAction func moveToNotification(_ sender: UIButton) {
        let notificationVC = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
                
        present(notificationVC, animated: true)
    }
    
}

// MARK: - DelegateViewControllerDelegate
extension ViewController: DelegateViewControllerDelegate {
    func passString(string: String) {
        delegateLabel.text = string
    }
}

