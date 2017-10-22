//
//  MyStocksCell.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/14/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol stockSelectedDelegate {
    func stockSelectedPressed(_ stock: Stock)
}

class MyStocksCell: UITableViewCell {

    @IBOutlet weak var positiveNegativeIndicatorImageView: UIImageView!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockTickerLabel: UILabel!

    var delegate: stockSelectedDelegate?
    var stock: Stock!
    
    func populateCell(stock: Stock, selectedType: MyStocksController.StockClassificationSelected) {
        self.stock = stock
        stockNameLabel.text = stock.name
        stockTickerLabel.text = stock.ticker
        stockPriceLabel.text = stock.currentPrice
    }
    
    @IBAction func stockSelected(_ sender: Any) {
        guard let stockPrice = stockPriceLabel.text else { return }
        guard let stockName = stockNameLabel.text else { return }
        guard let stockTicker = stockTickerLabel.text else { return }
        if let delegate = delegate {
            delegate.stockSelectedPressed(Stock(name: stockName, ticker: stockTicker, purchasedAt: stock.purchasedAt, shares: stock.shares, currentPrice: stockPrice, postKey: stock.postKey))
        }
    }
    
}
