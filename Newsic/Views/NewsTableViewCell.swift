//
//  NewsTableViewCell.swift
//  Newsic
//
//  Created by Bryan's Air on 11/5/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellSaveButton: UIButton!
    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellSourceLabel: UILabel!
    
    var buttonObject : (() -> Void)? = nil

    @IBAction func saveButtonPressed(_ sender: Any) {
        if let btnAction = self.buttonObject
        {
            btnAction()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
