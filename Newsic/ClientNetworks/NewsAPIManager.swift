//
//  NewsAPIManager.swift
//  Newsic
//
//  Created by Bryan's Air on 10/31/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import Foundation

class NewsAPIManager {
    
    func getArticles(completionHandler: @escaping (Data) -> ()) {
        
        let site = "https://newsapi.org/v2/\(Constants.NewsParameterValues.EndPoint)?\(Constants.NewsParameterKeys.SortBy)=\(Constants.NewsParameterValues.SortBy)&\(Constants.NewsParameterKeys.Language)=\(Constants.NewsParameterValues.Language)&\(Constants.NewsParameterKeys.PageSize)=\(Constants.NewsParameterValues.PageSize)&\(Constants.NewsParameterKeys.SearchText)=\(Constants.NewsParameterValues.SearchText)&\(Constants.NewsParameterKeys.FromDate)=\(Constants.NewsParameterValues.FromDate)&\(Constants.NewsParameterKeys.APIKey)=\(Constants.NewsParameterValues.APIKey)"
        let url = URL(string: site)
        var request = URLRequest(url: url!)
        
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
