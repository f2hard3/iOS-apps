//
//  CustomTableViewCell.swift
//  Chat
//
//  Created by Sunggon Park on 2024/03/16.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
