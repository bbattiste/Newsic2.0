//
//  NewsTableViewController.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewsTableViewController: UITableViewController {
    
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet weak var newsTableViewActivityIndicator: UIActivityIndicatorView!
    
    let dataController = DataController(modelName: "Newsic")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        newsTableViewActivityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        newsTableViewActivityIndicator.startAnimating()
        
        //MARK: NAV BAR buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItem.Style(rawValue: 2)!, target: self, action: #selector(NewsTableViewController.goToSearch))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Saved Articles", style: UIBarButtonItem.Style(rawValue: 2)!, target: self, action: #selector(NewsTableViewController.goToSavedArticles))
        
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
            
        self.dataController.load()
        }
    }
    
    // MARK: Functions
    
    @objc func goToSearch() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func goToSavedArticles() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SavedTableViewController") as! SavedTableViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func createReadableDate(dateToConvert: String) -> String {
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let deconstructedDate = deFormatter.date(from: dateToConvert)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        let newDate = formatter.string(from: deconstructedDate!)
        return newDate
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsTableViewCell
        
        let articleForCell = GlobalVariables.articleArray[(indexPath as NSIndexPath).row]
        
        // Configure the cell...
        // Title
        cell.cellLabel?.text = articleForCell["title"] as? String
        
        // Date
        let dateToUse = createReadableDate(dateToConvert: (articleForCell["publishedAt"] as? String)!)
        cell.cellDateLabel?.text = dateToUse
        
        // Image
        let urlCheck = articleForCell["urlToImage"]
        if urlCheck is NSNull || urlCheck as? String == ("") {
            performUIUpdatesOnMain {
                cell.cellImage?.image = UIImage(named: "missingImage")
            }
        } else {
            if let url = URL(string: (articleForCell["urlToImage"] as? String)!) {
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
        if let sourceDictionary = articleForCell["source"] as? [String: AnyObject] {
            let sourceToUse = sourceDictionary["name"] as? String
            cell.cellSourceLabel?.text = sourceToUse
        }
        
        // Save Button
        cell.buttonObject =
            {
                //TODO: IF article is saved, row already be in saved state
                print("buttonTapped")
                if cell.cellSaveButton.titleLabel!.text! == "Save" {
                    cell.cellSaveButton.backgroundColor = UIColor.gray
                    cell.cellSaveButton.setTitle("Saved", for: UIControl.State.normal)
                    
                    let articleToSave = Article(context: self.dataController.viewContext)
                    articleToSave.title = cell.cellLabel?.text
                    articleToSave.date = cell.cellDateLabel?.text
                    articleToSave.imageURL = articleForCell["urlToImage"] as? String
                    articleToSave.source = cell.cellSourceLabel?.text
                    articleToSave.urlString = articleForCell["url"] as? String
                    articleToSave.saveDate = Date()
                        
                    try? self.dataController.viewContext.save()
                    
                    print("data saved")
                } else {
                    cell.cellSaveButton.backgroundColor = #colorLiteral(red: 0.3346201153, green: 0.05490531069, blue: 0.5738618338, alpha: 1)
                    cell.cellSaveButton.setTitle("Save", for: UIControl.State.normal)
                }
                
                
                //cell.cellSaveButton.titleLabel = "Saved"
                // Save article entity of 5 attributes including url
                //let articleToSave = Article(context: self.dataController.viewContext)
//                articleToSave.title = cell.cellLabel?.text
//                print("title from tap = \(String(describing: articleToSave.title))")
                
                //self.view.addSubview(self.someotherView)
        }
        
        newsTableViewActivityIndicator.stopAnimating()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        newsTableViewActivityIndicator.startAnimating()
        let article = GlobalVariables.articleArray[(indexPath as NSIndexPath).row]
        let articleURL = article["url"] as! String
        UIApplication.shared.open(URL(string: articleURL)!, options: [:], completionHandler: { (status) in
        })
        newsTableViewActivityIndicator.stopAnimating()
        newsTableView.deselectRow(at: newsTableView.indexPathForSelectedRow!, animated: false)
    }
    
}
