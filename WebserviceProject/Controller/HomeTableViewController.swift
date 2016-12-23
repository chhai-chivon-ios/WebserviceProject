//
//  HomeTableViewController.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/21/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var article : [Article]?
    
    var articleService : ArticleService?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial
        article = [Article]()
        articleService?.getData(page: 1, limit: 15)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.article?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableVIewCell", for: indexPath) as! HomeTableViewCell
        cell.homeTitleLabel.text = "Pisith Ly"
        cell.homeDescriptionLabel.text = "Description"
        cell.homeImageView.image = #imageLiteral(resourceName: "103308459-RTX22GPJ.530x298")
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
