//
//  MyStocksController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/9/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import Alamofire
import SwiftyJSON

class MyStocksController: UIViewController {

    @IBOutlet weak var allStocksSelectedImageView: UIImageView!
    @IBOutlet weak var shortStocksSelectedImageView: UIImageView!
    @IBOutlet weak var longStocksSelectedImageView: UIImageView!
    @IBOutlet weak var myStocksTableView: UITableView!
    
    var userStocks = [Stock]()
    var selectedTypeStocks = [Stock]()
    var selectedStockType: StockClassificationSelected = .ALL
    
    enum StockClassificationSelected {
        case SHORT
        case LONG
        case ALL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStocksTableView.delegate = self
        myStocksTableView.dataSource = self
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 0.0
        pullUserStocks(userUID: (Auth.auth().currentUser?.uid)!) { (pulledStocks) in
            if let pulledStocks = pulledStocks {
                self.userStocks = pulledStocks
                if (pulledStocks.count == 0) {
                    // HANDLE NO STOCKS ADDED YET
                } else {
                    var stockPrices: [String] = []
                    for (stock) in pulledStocks {
                        self.getCurrentStockPrice(ticker: stock.ticker, currentPriceCompletionHandler: { (currentPrice) in
                            if let currentPrice = currentPrice {
                                stock.currentPrice = currentPrice
                                stockPrices.append(currentPrice)
                                if (stockPrices.count == pulledStocks.count) {
                                    self.checkForStockType()
                                }
                            } else {
                                // handle
                            }
                        })
                    }
                }
            } else {
                // Handle error if unable to parse alpha vantage data
            }
        }
    }
    
    private func checkForStockType() {
        selectedTypeStocks.removeAll()
        for (stock) in userStocks {
            if (selectedStockType == .ALL) {
                selectedTypeStocks.append(stock)
            } else {
                if (stock.type == selectedStockType) {
                    selectedTypeStocks.append(stock)
                }
            }
        }
        myStocksTableView.reloadData()
    }
    
    private func pullUserStocks(userUID: String, completionHandler: @escaping (_ stocks: [Stock]?) -> Void) {
        let userReference = Database.database().reference().child("Stocks").child(userUID)
        var pulledStocks = [Stock]()
        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let stock = Stock(postkey: snap.key, postData: postDict)
                        pulledStocks.append(stock)
                    }
                }
            }
            completionHandler(pulledStocks)
        }) { (error) in
            completionHandler(nil)
        }
    }
    
    private func getCurrentStockPrice(ticker: String, currentPriceCompletionHandler: @escaping (_ stockPrice: String?) -> Void) {
        let stockAnalyticsJSONUrl: String = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(ticker)&interval=1min&outputsize=compact&apikey=80URCYB65S5YLJKI"
        Alamofire.request(URL(string: stockAnalyticsJSONUrl)!, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let stockAnalyticJSON = JSON(value)["Time Series (1min)"]
                var stockPricesArray: [JSON] = []
                for (stockInfoAtTime):(String, JSON) in stockAnalyticJSON {
                    stockPricesArray.append(stockInfoAtTime.1)
                }
                if let currentPrice = Float(stockPricesArray[0]["4. close"].stringValue) {
                    currentPriceCompletionHandler(String(format: "%.2f", currentPrice))
                }
            case .failure( _):
                currentPriceCompletionHandler(nil)
            }
        }
    }
    
    @IBAction func allStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 0
        allStocksSelectedImageView.alpha = 100.0
        selectedStockType = StockClassificationSelected.ALL
        checkForStockType()
    }
    
    @IBAction func shortStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 100.0
        allStocksSelectedImageView.alpha = 0.0
        selectedStockType = StockClassificationSelected.SHORT
        checkForStockType()
    }
    
    @IBAction func longStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 100.0
        shortStocksSelectedImageView.alpha = 0.0
        allStocksSelectedImageView.alpha = 0.0
        selectedStockType = StockClassificationSelected.LONG
        checkForStockType()
    }
    
    @IBAction func addNewStockButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let signOutPrompt = UIAlertController(title: "Are you sure you want sign out?", message:
            "Please confirm that you would like to sign out.", preferredStyle: UIAlertControllerStyle.alert)
        signOutPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        signOutPrompt.addAction(UIAlertAction(title: "Sign Out", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) in
            KeychainWrapper.standard.removeObject(forKey: "uid")
            self.performSegue(withIdentifier: "signOutSegue", sender: nil)
        }))
        present(signOutPrompt, animated: true, completion: nil)
    }
    
}

extension MyStocksController: stockSelectedDelegate {
    func stockSelectedPressed(_ stock: Stock) {
        self.performSegue(withIdentifier: "toStockAnalyticsSegue", sender: nil)
    }
}

extension MyStocksController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTypeStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = selectedTypeStocks[indexPath.row]
        if let stockCell = myStocksTableView.dequeueReusableCell(withIdentifier: "stockCell") as? MyStocksCell {
            stockCell.delegate = self
            stockCell.backgroundColor = UIColor.clear
            stockCell.populateCell(stock: stock, selectedType: selectedStockType)
            return stockCell
        } else {
            return MyStocksCell()
        }
    }
    
}


