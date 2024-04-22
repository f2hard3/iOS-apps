//
//  ProfileTableViewCell.swift
//  SettingCloneApp
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileTitle: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        
        profileTitle.textColor = .blue
        profileTitle.font = UIFont.systemFont(ofSize: 20)
        
        profileDescription.textColor = .darkGray
        profileDescription.font = UIFont.systemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
