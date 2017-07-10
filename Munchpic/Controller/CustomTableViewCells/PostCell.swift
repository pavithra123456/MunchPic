//
//  PostCell.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 07/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
