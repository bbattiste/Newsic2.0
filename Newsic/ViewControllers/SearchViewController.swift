//
//  LoginViewController.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SearchViewController: UIViewController {

//------------------------------------------------------------------------------
// MARK: Outlets and variables
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var activityIndicatorSearch: UIActivityIndicatorView!
    @IBOutlet var searchView: UIView!
    
//------------------------------------------------------------------------------
// MARK: Lets/Vars
    
    var dataController: DataController!
    
//------------------------------------------------------------------------------
// MARK: Lifecyle
    
    // Lock phone orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable loginView tapable to return from firstResponder
        searchView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
//------------------------------------------------------------------------------
// MARK: Actions
    
    // Login
    @IBAction func search(_ sender: Any) {
        
        performUIUpdatesOnMain {
            self.activityIndicatorSearch.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.activityIndicatorSearch.startAnimating()
            self.searchButton.isEnabled = false
            self.debugTextLabel.text = ""
        }
        
        // If textField is empty, return with label: Search Field Empty
        if self.searchTextField.text!.isEmpty {
            performUIUpdatesOnMain {
                self.debugTextLabel.text = "Search Field Empty"
                self.searchButton.isEnabled = true
                self.activityIndicatorSearch.stopAnimating()
            }
            return
        } else {
            // capture textField to be used in client API
            if let searchString = searchTextField.text {
                Constants.NewsParameterValues.SearchText = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            }
            
            // Perform API request
            NewsClient.shared.requestBandArticles() { (success, error) in
                if success {
                    self.completeLogin()
                } else {
                    performUIUpdatesOnMain {
                        self.debugTextLabel.text = error!
                        self.searchButton.isEnabled = true
                        self.activityIndicatorSearch.stopAnimating()
                    }
                }
            }
        }
        
    }
    
//------------------------------------------------------------------------------
// MARK: Functions
    
    @objc func completeLogin() {
        performUIUpdatesOnMain {
            // move to NewsTableViewController
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
            self.navigationController?.pushViewController(controller, animated: true)
            
            self.setUIEnabled(true)
            self.activityIndicatorSearch.stopAnimating()
        }
    }

}

//------------------------------------------------------------------------------
// MARK: - LoginViewController: UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    // textfields will return with touch on view
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    @objc func tapGesture() {
        resignIfFirstResponder(searchTextField)
    }
    
}

//------------------------------------------------------------------------------
// MARK: - LoginViewController (Configure UI)

private extension SearchViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        searchTextField.isEnabled = enabled
        searchButton.isEnabled = enabled
        debugTextLabel.text = ""
        debugTextLabel.isEnabled = enabled
    }
}
