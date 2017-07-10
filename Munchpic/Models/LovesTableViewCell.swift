//
//  LovesTableViewCell.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/06/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class LovesTableViewCell: UITableViewCell {

    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
