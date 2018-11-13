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
    
    
    
    var testArray = ["a", "b", "c", "d", "e"]
    var savedArticles = [Article]()
    let dataController = DataController(modelName: "Newsic")
    var fetchedResultsController:NSFetchedResultsController<Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display an Edit button in the navigation bar.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("vewWillAppear called")
        performUIUpdatesOnMain {
            self.savedTableView.reloadData()
        }
//        fetchSavedArticles()
//        if let articlesTOPrint = fetchedResultsController.fetchedObjects {
//            print("articlesTOPrint = \(articlesTOPrint)")
//        }
        self.dataController.load()
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            print(result)
            savedArticles = result
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewWillDissapear called")
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
        performUIUpdatesOnMain {
            self.savedTableView.reloadData()
        }
    }
    
    // MARK: Functions
    
    func fetchSavedArticles() {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        let predicate = NSPredicate(format: "source == %@", "Slate.com")
        fetchRequest.predicate = predicate
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "saveDate", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
        do {
            try self.fetchedResultsController.performFetch()
            print("fetchPerformed")
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func deleteArticle() {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedArticles.count
        
//        print(fetchedResultsController.sections?[section].numberOfObjects as! Int)
//        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
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
        
        // Save Button
        cell.buttonObject =
            {
            print("button tapped")
                
//            let articleToDelete = .object(at: indexPath)
//            dataController.viewContext.delete(photoToDelete)
//            try? dataController.viewContext.save()
        }
        
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
                print("data deleted")
                if let index = self.savedArticles.index(of: article) {
                    self.savedArticles.remove(at: index)
                }
                print("article deleted")
                self.savedTableView.deleteRows(at: [indexPath], with: .automatic)
                print("Article and row deleted")
                return
            }
            
//            self.catNames.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//extension SavedTableViewController: NSFetchedResultsControllerDelegate {
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//
//    }
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    }
//}
