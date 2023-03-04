//
//  CustomNibTableViewCell.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 6/12/22.
//

import UIKit

class CustomNibTableViewCell: UITableViewCell {

    @IBOutlet weak var customNibLabel: UILabel!
    
    @IBOutlet weak var customNibImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
