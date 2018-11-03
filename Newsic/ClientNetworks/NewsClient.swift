//
//  NewsClient.swift
//  Newsic
//
//  Created by Bryan's Air on 10/29/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewsClient: NSObject {
    
    //attribution: Wyatt Mufson: https://github.com/WyattMufson/NewsAPI-Swift
    
    static var shared = NewsClient()
    
    func requestBandArticles(completionHandler: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        let key = "9c9d15331d164c079625dddab874cb90"
        let nam = NewsAPIManager() // Initialize News API Manager
        let band = "metallica" // TODO = Make band URL-encoded
        
        let monthsToSubtract = -1
        let oneMonthAgoDate = Calendar.current.date(byAdding: .month, value: monthsToSubtract, to: Date())
        let oneMonthAgoUsableString = usableDate(date: oneMonthAgoDate!)
        
        //TODO: to become userdefaults
        //var currentArticles = [UserDefaults.standard.object(forKey: "NewsAPI-Swift Articles")]
        var currentArticles = GlobalVariables.articleArray
        
        nam.getArticles(band: band, oldestArticleDate: oneMonthAgoUsableString, key: key) {data in // Getting articles from "everything" search
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let jsonArray = json as? [String: AnyObject] {
                    if let articles = jsonArray["articles"] as? [[String : AnyObject]] {
                        for article in articles { // Get each article, only one as of now
                            currentArticles.append(article)
                            //print(String(describing: article))
                        }
                        //print(currentArticles)
                        GlobalVariables.articleArray = currentArticles
                        print("GlobalVariables count in call = \(GlobalVariables.articleArray.count)")
                        //print(GlobalVariables.articleArray)
                        
                        // If wanting more than 1 article per artist, use this to not duplicate: !currentArticles.contains(article) {
                        //currentArticles.append(article)
                        //}
                        // Use to save to userdefaults: UserDefaults.standard.set(currentArticles, forKey: "NewsAPI-Swift Articles")
                    }
                    completionHandler(true, nil)
                }
            } catch {
                print("error serializing JSON: \(String(describing:error))")
                completionHandler(false, String(describing: error))
            }
        }
    }
    
    // Create usable dates for client
    func usableDate(date: Date) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
}

