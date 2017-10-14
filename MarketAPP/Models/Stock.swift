//
//  Stock.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/14/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation

class Stock {
    
    var name: String!
    var ticker: String!
    var price: String!
    var postKey: String!
    
    init(name: String, ticker: String, price: String, postKey: String) {
        self.name = name
        self.ticker = ticker
        self.price = price
        self.postKey = postKey
    }
    
    init(postkey: String, postData: Dictionary<String, AnyObject>) {
        self.postKey = postkey
        
        if let name = postData["name"] as? String {
            self.name = name
        }
        if let ticker = postData["ticker"] as? String {
            self.ticker = ticker
        }
        if let price = postData["price"] as? String {
            self.price = price
        }
        
    }
    
}
