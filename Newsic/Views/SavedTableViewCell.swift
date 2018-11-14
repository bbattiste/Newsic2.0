//
//  SavedTableViewCell.swift
//  Newsic
//
//  Created by Bryan's Air on 11/12/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellSourceLabel: UILabel!
    @IBOutlet weak var cellActivityIndicatorImage: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        cellActivityIndicatorImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }

}
