//
//  MovieCell.swift
//  MoviePick
//
//  Created by Rosy Wanasinghe on 24/8/21.
//

import UIKit
import SwipeCellKit

class MovieCell: SwipeTableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
