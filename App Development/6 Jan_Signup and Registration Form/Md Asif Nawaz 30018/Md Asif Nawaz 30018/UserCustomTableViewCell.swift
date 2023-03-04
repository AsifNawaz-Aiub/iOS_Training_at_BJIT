//
//  UserCustomTableViewCell.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 10/1/23.
//

import UIKit

class UserCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var note: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
