//
//  MovieCellsTableViewCell.swift
//  flix_feed_1
//
//  Created by macstudent on 9/28/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit

class MovieCellsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var PosterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
