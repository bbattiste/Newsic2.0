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
    
    // TODO: If no article pops up, turn label that says "Not all of your top listened to artists have current news!" - List top artists without news.
    func getArticles(band: String, oldestArticleDate: String, key: String, completionHandler: @escaping (Data) -> ()) {
        // TODO: Not sure this will work, because if band name is searched, it will not matter to include other words...: Make q = section: q=\(band)OR\(band)SPACEbandOR\(band)SPACEtour& and even possibly add \(band)SPACEmusic&
        // sortby can be:
        //relevancy = articles more closely related to q come first.
        //popularity = articles from popular sources and publishers come first.
        //publishedAt = newest articles come first. Default
        let site = "https://newsapi.org/v2/everything?sortBy=relevancy&language=en&pageSize=1&q=\(band)&from=\(oldestArticleDate)&apiKey=\(key)"
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
