//
//  HomeTableViewCell.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/22/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeTitleLabel: UILabel!
    @IBOutlet weak var homeDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(article: Article) {
         self.homeTitleLabel.text = article.title
         self.homeDescriptionLabel.text = article.description
         self.homeImageView.kf.setImage(with:URL(string: article.image!), placeholder: #imageLiteral(resourceName: "103308459-RTX22GPJ.530x298") )
    }
}
