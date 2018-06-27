//
//  ArticleTableViewCell.swift
//  CodingAssessmentApp
//
//  Created by Laxman Sahni on 26/06/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleIconImageView: UIImageView!
    @IBOutlet weak var articleAbstractLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Make article imageview round
        
        articleIconImageView.clipsToBounds = true
        articleIconImageView.layer.cornerRadius = ((54.67 * UIScreen.main.bounds.width)/375.0)/2.0
        articleIconImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
