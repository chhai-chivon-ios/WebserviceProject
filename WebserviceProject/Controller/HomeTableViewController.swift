//
//  HomeTableViewController.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/21/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var articles : [Article]?
    var article = Article()
    var articlePresenter : ArticlePresenter?
    var cheeck : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial
        articles = [Article]()
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        articlePresenter?.getData(page: 1, limit: 15)
        self.refreshControl?.addTarget(self, action: #selector(self.refrshControlHandler), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // cheeck form which one you need to pop up
        if segue.identifier == "homeToDetail"{
            let sc : DetailTableViewController = segue.destination as! DetailTableViewController
            sc.article = self.article
        }else{
            let sc1 : EditedTableViewController = segue.destination as! EditedTableViewController
            // cheeck button boolean value
            if cheeck == false {
                sc1.article = self.article
                sc1.navigationItem.title = "Update"
            }else{
                sc1.navigationItem.title = "Add"
            }
       }
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.articles?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableVIewCell", for: indexPath) as! HomeTableViewCell
        // set value to table cell with custom configureCell in Custom cell
        cell.configureCell(article: (self.articles?[indexPath.row])!)
        return cell
    }
 
    @IBAction func addButton(_ sender: Any) {
         // set boolean value for botton to edit or add
         cheeck = true
         self.performSegue(withIdentifier: "homeToAdd", sender: self)
        
    }
 
    func refrshControlHandler() {
        self.articles?.removeAll()
        self.articlePresenter?.getData(page: 1, limit: 15)
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        article = (self.articles?[indexPath.row])!
        self.performSegue(withIdentifier: "homeToDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: .normal, title: "Edit", handler:{action, indexpath in
            // set boolean value for botton to edit or add
            self.cheeck = false
            // set value for article object to edit viewcontroller
            self.article = (self.articles?[indexPath.row])!
            // pop up view controller
            self.performSegue(withIdentifier: "homeToAdd", sender: self)
        })
        
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Delete", handler:{action, indexpath in
            self.articlePresenter?.deleteData(articleID: (self.articles?[indexPath.row].id)!, completion: { (status) in
                if status == true {
                    // remove array item
                    self.articles?.remove(at: indexPath.row)
                    // remove cell for row
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            
       })
        
        return [deleteRowAction, moreRowAction];
    }
    // request more page
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cheeck pagination
        if  indexPath.row >= (self.articles?.count)! - 1 {
            if Pagination.shared.curentPage < Pagination.shared.totalPage {
                self.articlePresenter?.getData(page: Pagination.shared.curentPage + 1, limit: 15)
            }
        }
    }
    
}

// Conform Protocol to get
extension HomeTableViewController : ArticlePresenterProtocol {
    
    func ResponseArticle(articles: [Article]) {
        self.articles?.append(contentsOf: articles)
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
}
