//
//  SearchFileterCell.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 24/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class SearchFileterCell: UITableViewCell {

    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var loveImage: UIImageView!
    @IBOutlet weak var cuisineLAbel: UILabel!
    @IBOutlet weak var lovesCountLAbel: UILabel!
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
