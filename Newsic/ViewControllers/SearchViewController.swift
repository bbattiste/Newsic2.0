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
    
    // MARK: Outlets and variables
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var activityIndicatorLogin: UIActivityIndicatorView!
    @IBOutlet var searchView: UIView!
    
    // MARK: Lets/Vars
    var dataController: DataController!
    
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
    
    // MARK: Actions
    
    // Login
    @IBAction func search(_ sender: Any) {
        activityIndicatorLogin.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicatorLogin.startAnimating()
        searchButton.isEnabled = false
        
        debugTextLabel.text = ""
        
        if searchTextField.text!.isEmpty {
            debugTextLabel.text = "search Field Empty"
            searchButton.isEnabled = true
            activityIndicatorLogin.stopAnimating()
            return
        } else {
            if let searchString = searchTextField.text {
                Constants.NewsParameterValues.SearchText = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            }
        }
        
        // postSession()
        completeLogin()
    }
    
    // MARK: Functions
    
    @objc func completeLogin() {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            self.setUIEnabled(true)
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "NewsicTabBarController") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
            
            self.searchButton.isEnabled = true
            self.activityIndicatorLogin.stopAnimating()
        }
    }
    
    func displayError(_ error: String){
        performUIUpdatesOnMain {
            self.setUIEnabled(true)
            self.debugTextLabel.text = error
        }
    }
    
}

// MARK: - LoginViewController: UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    // textfields will return with enter key
    // TODO:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
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

// MARK: - LoginViewController (Configure UI)

private extension SearchViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        searchTextField.isEnabled = enabled
        searchButton.isEnabled = enabled
        debugTextLabel.text = ""
        debugTextLabel.isEnabled = enabled
    }
}
