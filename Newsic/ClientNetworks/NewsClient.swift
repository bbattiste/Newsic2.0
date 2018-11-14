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
    
    static var shared = NewsClient()
    
    func requestBandArticles(completionHandler: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        // Initialize News API Manager
        let nam = NewsAPIManager()
        
        // Get 29 days ago to conform to newsAPI standards fromDate
        let monthsToSubtract = -1
        let daysToAdd = 1
        let oneMonthAgoDate = Calendar.current.date(byAdding: .month, value: monthsToSubtract, to: Date())
        let datePlusOneDay = Calendar.current.date(byAdding: .day, value: daysToAdd, to: oneMonthAgoDate!)
        Constants.NewsParameterValues.FromDate = usableDate(date: datePlusOneDay!)
        
        // Getting articles from "everything" search in News API Manager
        nam.getArticles() {data in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let jsonArray = json as? [String: AnyObject] {
                    
                    guard let totalResults = jsonArray["totalResults"] as? Int else {
                        completionHandler(false, "Cannot find key 'totalResults' in jsonArray")
                        return
                    }
                    
                    if totalResults == 0 {
                        completionHandler(false, "No Results For Search, Try Again")
                        return
                    }
                    
                    if let articles = jsonArray["articles"] as? [[String : AnyObject]] {
                        GlobalVariables.articleArray = articles
                    }
                    completionHandler(true, nil)
                }
            } catch {
                completionHandler(false, String(describing: error))
            }
        }
    }
    
    // Create usable dates for client
    func usableDate(date: Date) -> String {
        let formatter = DateFormatter()
        //set formatter String date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // convert date to string with formatter
        let oldString = formatter.string(from: date)
        // convert string to date
        let newDate = formatter.date(from: oldString)
        //set date format to needed output
        formatter.dateFormat = "yyyy-MM-dd"
        // convert date to string with formatter
        let newStringDate = formatter.string(from: newDate!)
        
        return newStringDate
    }
    
}

