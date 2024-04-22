//
//  ViewController.swift
//  DispatchQueue
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func button1(_ sender: UIButton) {
        executeClosure {
            self.endLabel.text = "End!"
        }
    }
    
    private func executeClosure(completion: @escaping  () -> Void) {
//        Task {
//            for i in 0..<10 {
//                try await Task.sleep(nanoseconds: 2)
//                print(i)
//            }
//        }
        DispatchQueue.global().async {
            for i in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    @IBAction func button2(_ sender: UIButton) {
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
        
        queue1.async(group: dispatchGroup, qos: .background) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for i in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(i)
                }
                dispatchGroup.leave()
            }
        }
        
        queue2.async(group: dispatchGroup, qos: .userInteractive) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for i in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(i)
                }
                dispatchGroup.leave()
            }
        }
        
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for i in 21..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(i)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("dispatchGroup end!")
        }
    }
    
    @IBAction func button3(_ sender: UIButton) {
//        DispatchQueue.main.sync {
//            print("Alway get in the deadlock because the main thread never ends")
//        }
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        queue1.sync {
            for i in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
            
            // deadlock: waiting for each other to finish forever
//            queue1.sync {
//                for i in 0..<10 {
//                    Thread.sleep(forTimeInterval: 0.2)
//                    print(i)
//                }
//            }
        }
        
        queue2.sync {
            for i in 11..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
        }
    }
}

