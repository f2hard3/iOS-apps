//
//  ViewController.swift
//  ExpandedCell
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cells = [ExpandedCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let textData = getData()
        cells = textData.map({ text in
            ExpandedCellModel(description: text, isExpanded: false)
        })
    }
    
    private func getData() -> [String] {
        let textArray = [
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
            "short text",
            "long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text",
        ]
        
        return textArray
    }
    
}

// MARK: - TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandedCell", for: indexPath) as! ExpandedCell
        cell.selectionStyle = .none
        
        if cells[indexPath.row].isExpanded {
            cell.descriptionLabel.numberOfLines = 0
        } else {
            cell.descriptionLabel.numberOfLines = 1
        }
        cell.descriptionLabel.text = cells[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cells[indexPath.row].isExpanded = !cells[indexPath.row].isExpanded
        
//        UIView.setAnimationsEnabled(false)
        tableView.reloadRows(at: [indexPath], with: .automatic)
//        UIView.setAnimationsEnabled(true)
    }
}

