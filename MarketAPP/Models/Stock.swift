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
    var shares: Int!
    var type: MyStocksController.StockClassificationSelected!
    var currentPrice: String?
    var postKey: String!
    
    init(name: String, ticker: String, purchasedAt: String, type: MyStocksController.StockClassificationSelected, shares: Int, postKey: String) {
        self.name = name
        self.ticker = ticker
        self.purchasedAt = purchasedAt
        self.type = type
        self.shares = shares
        self.postKey = postKey
    }
    
    init(name: String, ticker: String, purchasedAt: String, shares: Int, currentPrice: String, postKey: String) {
        self.name = name
        self.ticker = ticker
        self.purchasedAt = purchasedAt
        self.shares = shares
        self.currentPrice = currentPrice
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
        if let shares = postData["shares"] as? Int {
            self.shares = shares
        }
    }
    
}



