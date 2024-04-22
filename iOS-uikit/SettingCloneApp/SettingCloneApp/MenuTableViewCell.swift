//
//  MenuTableViewCell.swift
//  SettingCloneApp
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var goToImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
