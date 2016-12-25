//
//  EditedTableViewController.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/25/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

class EditedTableViewController: UITableViewController {

    @IBOutlet weak var UploadimageView: UIImageView!
    
    @IBOutlet weak var UploadTitle: UITextField!
    
    @IBOutlet weak var UploadDescription: UITextView!
   
    
    var presenter : ArticlePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ArticlePresenter()
        self.presenter?.delegate = self
    }
    
    @IBAction func Save(_ sender: Any) {
        let article = Article()
        article.title = UploadTitle.text
        article.description = UploadDescription.text
        let image = UploadimageView.image!
        let data = ["article": article ,"image": image] as [String : Any]
        presenter?.postData(data: data)
        
    }
    
}

extension EditedTableViewController : ArticlePresenterProtocol {

    func didResponseDataPost(articles: Article) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}
