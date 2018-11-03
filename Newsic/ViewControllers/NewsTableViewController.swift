//
//  NewsTableViewController.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    @IBOutlet var newsTableView: UITableView!
    
    
    var testArray = ["a", "b", "c", "d", "e"]
    //[[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsClient.shared.requestBandArticles() { (success, error) in
            if success {
                performUIUpdatesOnMain {
                    self.newsTableView.reloadData()
                }
            } else {
                performUIUpdatesOnMain {
                    print(error!)
                    //self.activityIndicatorPhoto.stopAnimating()
                    //self.missingImagesLabel.isHidden = false
                    //self.photoCollectionView.isScrollEnabled = true
                }
            }
        }
        
        // Display an Edit button in the navigation bar.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("GlobalVariables.articleArray.count = \(GlobalVariables.articleArray.count)")
        return GlobalVariables.articleArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        let articleForCell = testArray[(indexPath as NSIndexPath).row]
        
        print("cellForRowAt called")
        // Configure the cell...
        cell.textLabel?.text = articleForCell
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Grab the ArticleViewController from Storyboard
        let articleController = self.storyboard!.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        
        //Populate view controller with data from the selected item
        
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(articleController, animated: true)
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
