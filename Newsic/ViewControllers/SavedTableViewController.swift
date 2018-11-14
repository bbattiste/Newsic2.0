//
//  SavedTableViewController.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit
import CoreData

class SavedTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Outlets
    @IBOutlet var savedTableView: UITableView!
    @IBOutlet weak var savedTableViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    // MARK: Vars/lets
    
    var savedArticles = [Article]()
    let dataController = DataController(modelName: "Newsic")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Adjust title font size in the navigation bar.

//        if let navController = navigationController {
//            navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "mplus-1c-regular", size: 21)!]
//        }
        
        if let navFont = UIFont(name: "mplus-1c-regular", size: 21) {
            let navBarAttributesDictionary: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): navFont ]
            UINavigationBar.appearance().titleTextAttributes = navBarAttributesDictionary
        }
        
        self.dataController.load()
    }
    
    // Reload table between tabbars
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.savedTableView.reloadData()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if isEditing == false {
            isEditing = true
            deleteButton.title = "Done"
        } else {
            isEditing = false
            deleteButton.title = "Delete"
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            print("savedResults = \(result)")
            savedArticles = result
        }
        return savedArticles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! SavedTableViewCell
        let articleForCell = savedArticles[(indexPath as NSIndexPath).row]
        
        print("cellForRowAt called")
        // Configure the cell...
        
        // Title
        cell.cellLabel?.text = articleForCell.title
        
        // Date
        cell.cellDateLabel?.text = articleForCell.date
        
        // Image
        let urlCheck = articleForCell.imageURL
        if urlCheck == nil || urlCheck == ("") {
            performUIUpdatesOnMain {
                cell.cellImage?.image = UIImage(named: "missingImage")
            }
        } else {
            if let url = URL(string: (articleForCell.imageURL)!) {
                DispatchQueue.global().async {
                    if let urlData = try? Data(contentsOf: url) {
                        performUIUpdatesOnMain {
                            cell.cellImage?.image = UIImage(data: urlData)
                        }
                    }
                }
            }
        }
        
        // Source
        cell.cellSourceLabel?.text = articleForCell.source
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = savedArticles[(indexPath as NSIndexPath).row]
        
        if isEditing {
            performUIUpdatesOnMain {
                self.dataController.viewContext.delete(article)
                try? self.dataController.viewContext.save()
                print("data deleted")
                if let index = self.savedArticles.index(of: article) {
                    self.savedArticles.remove(at: index)
                }
                print("article deleted")
                self.savedTableView.deleteRows(at: [indexPath], with: .automatic)
                print("Article and row deleted")
                return
            }
        } else {
            let articleURL = article.urlString
            savedTableViewActivityIndicator.startAnimating()
            UIApplication.shared.open(URL(string: articleURL!)!, options: [:], completionHandler: { (status) in
            })
            savedTableViewActivityIndicator.stopAnimating()
            savedTableView.deselectRow(at: savedTableView.indexPathForSelectedRow!, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let article = savedArticles[(indexPath as NSIndexPath).row]
            performUIUpdatesOnMain {
                self.dataController.viewContext.delete(article)
                try? self.dataController.viewContext.save()
                if let index = self.savedArticles.index(of: article) {
                    self.savedArticles.remove(at: index)
                }
                self.savedTableView.deleteRows(at: [indexPath], with: .automatic)
                self.navigationItem.rightBarButtonItem?.title = "Delete"
                return
            }
        }
    }
    
}
