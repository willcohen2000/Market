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
    var purchasedAt: String!
    var type: MyStocksController.StockClassificationSelected!
    var postKey: String!
    
    init(name: String, ticker: String, purchasedAt: String, type: MyStocksController.StockClassificationSelected, postKey: String) {
        self.name = name
        self.ticker = ticker
        self.purchasedAt = purchasedAt
        self.type = type
        self.postKey = postKey
    }
    
    init(name: String, ticker: String, purchasedAt: String, postKey: String) {
        self.name = name
        self.ticker = ticker
        self.purchasedAt = purchasedAt
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
        if let purchasedAt = postData["purchased"] as? String {
            self.purchasedAt = purchasedAt
        }
        if let type = postData["type"] as? String {
            if (type == "short") {
                self.type = MyStocksController.StockClassificationSelected.SHORT
            } else {
                self.type = MyStocksController.StockClassificationSelected.LONG
            }
        }
        
    }
    
}
