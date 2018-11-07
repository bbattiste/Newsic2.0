//
//  Constants.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import Foundation
import UIKit

// Mark: Constants
struct Constants {
    
    // MARK: News Parameter Keys
    
    struct NewsParameterKeys {
        static let APIKey = "apiKey"
        static let SearchText = "q"
        static let SortBy = "sortBy"
        static let Language = "language"
        static let PageSize = "pageSize"
        static let FromDate = "from"
    }
    
    
    // MARK: News Parameter Values
    struct NewsParameterValues {
        static let APIKey = "9c9d15331d164c079625dddab874cb90"
        static var SearchText = ""
        static let SortBy = "relevancy"
        static let Language = "en"
        static let PageSize = "20"
        static var FromDate = ""
        static let EndPoint = "everything"
    }
    
}

// Notes about Values:
//
// sortby can be:
//relevancy = articles more closely related to q come first.
//popularity = articles from popular sources and publishers come first.
//publishedAt = newest articles come first. Default
