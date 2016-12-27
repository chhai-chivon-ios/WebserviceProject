//
//  DetailTableViewController.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/25/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    var article = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTitle.text = article.title
        detailDescription.text = article.description
        detailImage.kf.setImage(with:URL(string: article.image!), placeholder: #imageLiteral(resourceName: "103308459-RTX22GPJ.530x298") )
    }

  }
