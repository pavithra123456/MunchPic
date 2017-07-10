//
//  CommentCell.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 05/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
