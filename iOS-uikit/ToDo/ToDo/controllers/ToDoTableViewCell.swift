//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Sunggon Park on 2024/03/21.
//

import UIKit
import CoreData

enum Prioirty: Int16 {
    case low
    case normal
    case high
    
    var color: UIColor {
        switch self {
        case .low: return .blue
        case .normal: return .yellow
        case .high: return .red
        }
    }
}

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var toDo: ToDo? {
        didSet {
            setupViews()
        }
    }
    
    private func setupViews() {
        guard let toDo = toDo else { return }
        titleLabel.text = toDo.title
        
        if let date = toDo.date {
            dateLabel.text = formatDate(date: date)
        } else {
            dateLabel.text = ""
        }
        
        priorityView.layer.cornerRadius = priorityView.bounds.height / 2
        priorityView.backgroundColor = Prioirty(rawValue: toDo.priority)?.color
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}
