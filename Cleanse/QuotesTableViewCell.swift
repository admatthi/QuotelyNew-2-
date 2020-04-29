//
//  QuotesTableViewCell.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/19/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class QuotesTableViewCell: UITableViewCell {

    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var tapdownvote: UIButton!
    @IBOutlet weak var tapShare: UIButton!
    @IBOutlet weak var blurimage: UIImageView!
    @IBOutlet weak var taplike: UIButton!
    @IBOutlet weak var likesimage: UIImageView!
    @IBOutlet weak var likesnumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
