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
    
    var articleService : ArticleService?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial
        articles = [Article]()
        articleService = ArticleService()
        articleService?.delegate = self
        articleService?.getData(page: 1, limit: 40)
        
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
}

// Conform Protocol to get data
extension HomeTableViewController : ArticleServiceProtocol {
    internal func didResponseData(articles: [Article]) {
        self.articles = articles
        self.tableView.reloadData()
    }

}
