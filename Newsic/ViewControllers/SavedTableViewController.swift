//
//  SavedTableViewController.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit
import CoreData

class SavedTableViewController: UITableViewController {

//------------------------------------------------------------------------------
// MARK: Outlets
    
    @IBOutlet var savedTableView: UITableView!
    @IBOutlet weak var savedTableViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
//------------------------------------------------------------------------------
// MARK: Vars/Lets
    
    var savedArticles = [Article]()
    let dataController = DataController(modelName: "Newsic")
    
//------------------------------------------------------------------------------
// MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataController.load()
    }
    
    // Reload table between tabs
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.savedTableView.reloadData()
    }
    
//------------------------------------------------------------------------------
// MARK: Actions
    
    // Toggle isEditing to delete data with delete button
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if isEditing {
            isEditing = false
            deleteButton.title = "Delete"
        } else {
            isEditing = true
            deleteButton.title = "Done"
        }
    }
    
//------------------------------------------------------------------------------
// MARK: Functions
    
    // Delete saved article and row containing article
    func deleteData(articleToDelete: Article, fromIndexPath: IndexPath) {
        performUIUpdatesOnMain {
            self.dataController.viewContext.delete(articleToDelete)
            try? self.dataController.viewContext.save()
            if let index = self.savedArticles.index(of: articleToDelete) {
                self.savedArticles.remove(at: index)
            }
            self.savedTableView.deleteRows(at: [fromIndexPath], with: .automatic)
            return
        }
    }
    
//------------------------------------------------------------------------------
// MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            savedArticles = result
        }
        return savedArticles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! SavedTableViewCell
        let articleForCell = savedArticles[(indexPath as NSIndexPath).row]

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
       
        // Delete row data if editing
        if isEditing {
            deleteData(articleToDelete: article, fromIndexPath: indexPath)
        } else {
            
            // Open article link in Safari
            let articleURL = article.urlString
            savedTableViewActivityIndicator.startAnimating()
            UIApplication.shared.open(URL(string: articleURL!)!, options: [:], completionHandler: { (status) in
            })
            savedTableViewActivityIndicator.stopAnimating()
            savedTableView.deselectRow(at: savedTableView.indexPathForSelectedRow!, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete row by swiping left
        if editingStyle == .delete {
            let article = savedArticles[(indexPath as NSIndexPath).row]
            deleteData(articleToDelete: article, fromIndexPath: indexPath)
        }
    }
    
}
