//
//  NewsAPIManager.swift
//  Newsic
//
//  Created by Bryan's Air on 10/31/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import Foundation

class NewsAPIManager {
    
    //attribution: Wyatt Mufson: https://github.com/WyattMufson/NewsAPI-Swift
    //newsAPI in readme github
    
    // TODO: If no article pops up, turn label that says "Not all of your top listened to artists have current news!" - List top artists without news.
    func getArticles(completionHandler: @escaping (Data) -> ()) {
        
        let site = "https://newsapi.org/v2/\(Constants.NewsParameterValues.EndPoint)?\(Constants.NewsParameterKeys.SortBy)=\(Constants.NewsParameterValues.SortBy)&\(Constants.NewsParameterKeys.Language)=\(Constants.NewsParameterValues.Language)&\(Constants.NewsParameterKeys.PageSize)=\(Constants.NewsParameterValues.PageSize)&\(Constants.NewsParameterKeys.SearchText)=\(Constants.NewsParameterValues.SearchText)&\(Constants.NewsParameterKeys.FromDate)=\(Constants.NewsParameterValues.FromDate)&\(Constants.NewsParameterKeys.APIKey)=\(Constants.NewsParameterValues.APIKey)"
        let url = URL(string: site)
        var request = URLRequest(url: url!)
        print("request = \(request)")
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            
            if (err != nil) {
                completionHandler(Data())
            } else {
                completionHandler(data!)
            }
            }.resume()
    }
}
