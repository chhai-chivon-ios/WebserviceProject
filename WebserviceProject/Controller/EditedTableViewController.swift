//
//  EditedTableViewController.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/25/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

class EditedTableViewController: UITableViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var UploadimageView: UIImageView!
    
    @IBOutlet weak var UploadTitle: UITextField!
    
    @IBOutlet weak var UploadDescription: UITextView!
    var imagePicker1: UIImagePickerController!
    var article = Article()
    var presenter : ArticlePresenter?
    var cheeck : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ArticlePresenter()
        self.presenter?.delegate = self
        //step1 To Login Into Librery Photos
        imagePicker1 = UIImagePickerController()
        imagePicker1.delegate = self
        UploadTitle.text = article.title
        UploadDescription.text = article.description
        UploadimageView.kf.setImage(with:URL(string: article.image!), placeholder: #imageLiteral(resourceName: "103308459-RTX22GPJ.530x298") )
    }
    
    //step2 To Login Into Librery Photos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            UploadimageView.image = img
            cheeck = true
            print("image controller  \(img)")
            print(true)
        }
        //print(imageUrl)
        imagePicker1.dismiss(animated: true, completion: nil)
    }

    @IBAction func Save(_ sender: Any) {
        article.title = UploadTitle.text
        article.description = UploadDescription.text
        let image = UploadimageView.image!
        let data = ["article": article ,"image": image] as [String : Any]
        // Cheeck navigate title to do operation
        if navigationItem.title == "Add" {
            presenter?.postData(data: data)
        }else{
            presenter?.updateData(data: data , cheeck: cheeck)
            print("Cheeck From View Controller:\(cheeck)")
        }
    }
    //step3 To Login Into Librery Photos
    @IBAction func imagePictker(_ sender: Any) {
        present(imagePicker1, animated: true, completion: nil)
        cheeck = false
        print("button Image")
        print("false")
    }
}

extension EditedTableViewController : ArticlePresenterProtocol {

    func didResponseDataPost(articles: Article) {
        // Pop Up Previous Controller
        _ = self.navigationController?.popViewController(animated: true)
       
    }
    func didResponseDataUpdate(articles: Article) {
        // Pop Up Previous Controller
        _ = self.navigationController?.popViewController(animated: true)
        //Change Navigate Title
        navigationItem.title = "Add"
    }
}
