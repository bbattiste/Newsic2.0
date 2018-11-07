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
    @IBOutlet weak var newsTableViewActivityIndicator: UIActivityIndicatorView!
    // TODO: add source of article to cell
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableViewActivityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        newsTableViewActivityIndicator.startAnimating()
        
        //MARK: NAV BAR buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style(rawValue: 2)!, target: self, action: #selector(NewsTableViewController.backOut))
                
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
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        }
    }
    
    // MARK: Functions
    
    @objc func backOut() {
        self.dismiss(animated: false, completion: nil)
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
        print("cellForRowAt called")
        
        // Configure the cell...
        cell.cellLabel?.text = articleForCell["title"] as? String
        // Date
        let dateToUse = createReadableDate(dateToConvert: (articleForCell["publishedAt"] as? String)!)
        cell.cellDateLabel?.text = dateToUse
        // Image
        if let imageURL = articleForCell["urlToImage"] as? String {
            if let url = URL(string: imageURL) {
                DispatchQueue.global().async {
                    if let urlData = try? Data(contentsOf: url) {
                        performUIUpdatesOnMain {
                            cell.cellImage?.image = UIImage(data: urlData)
                        }
                    }
                }
            }
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
    }
    
}
