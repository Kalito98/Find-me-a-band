//
//  BandTableViewCell.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 4/2/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

class BandTableViewCell: UITableViewCell {
    @IBOutlet weak var textLableBandName: UILabel!
    @IBOutlet weak var textLableBandCreator: UILabel!
    @IBOutlet weak var textLableBandGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
