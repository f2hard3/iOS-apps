//
//  ViewController.swift
//  Chat
//
//  Created by Sunggon Park on 2024/03/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    var chatData = [
        ChatModel(who: .you, message: "Hello"),
        ChatModel(who: .me, message: "Hello, how are you?"),
        ChatModel(who: .me, message: "Did you have breakfast?"),
        ChatModel(who: .you, message: "Yeah, how about you?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView
            .register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView
            .register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let height = keyboardFrame.height
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        UIView.animate(withDuration: animationDuration) {
            self.textViewBottomConstraint.constant = height - self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        UIView.animate(withDuration: animationDuration) {
            self.textViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func sendTapped(_ sender: UIButton) {
        guard let text = textView.text else { return }
        chatData.append(ChatModel(who: .me, message: text))
        textView.text = ""
        
        let lastIndexPath = IndexPath(row: chatData.count - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        //        tableView.reloadData()
        
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        
        textViewHeightConstraint.constant = 40
    }
    
}

// MARK: - UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatData[indexPath.row]
        
        if chat.who == .me {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CustomTableViewCell",
                for: indexPath
            ) as? CustomTableViewCell else {
                fatalError("Cannot cast to CustomTableViewCell")
            }
            cell.textView.text = chat.message
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CustomCell",
                for: indexPath
            ) as? CustomCell else {
                fatalError("Cannot cast to CustomCell")
            }
            cell.textView.text = chat.message
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

// MARK: - UITextView
extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contentHeight = textView.contentSize.height
        if contentHeight <= 40 {
            textViewHeightConstraint.constant = 40
        } else if contentHeight <= 100 {
            textViewHeightConstraint.constant = contentHeight
        } else {
            textViewHeightConstraint.constant = 100
        }
    }
}


