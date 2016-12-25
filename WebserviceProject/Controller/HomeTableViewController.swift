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
    
    var articlePresenter : ArticlePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial
        articles = [Article]()
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        articlePresenter?.getData(page: 1, limit: 15)
        self.refreshControl?.addTarget(self, action: #selector(self.refrshControlHandler), for: .valueChanged)
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
        cell.configureCell(article: (self.articles?[indexPath.row])!)
        return cell
    }
 
    func refrshControlHandler() {
        self.articles?.removeAll()
        self.articlePresenter?.getData(page: 1, limit: 15)
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "homeToDetail", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: .normal, title: "Edit", handler:{action, indexpath in
            
        })
        
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Delete", handler:{action, indexpath in
            print(" My Index  \((self.articles?[indexPath.row].id)!)")
            self.articlePresenter?.deleteData(articleID: (self.articles?[indexPath.row].id)!, completion: { (status) in
                if status == true {
                    self.articles?.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            
       })
        
        return [deleteRowAction, moreRowAction];
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
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
