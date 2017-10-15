//
//  StockAnalyticsController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/14/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StockAnalyticsController: UIViewController {

    @IBOutlet weak var stockPriceView: UIView!
    @IBOutlet weak var percentReturnLabel: UILabel!
    @IBOutlet weak var dollarReturnLabel: UILabel!
    @IBOutlet weak var openedTodayLabel: UILabel!
    @IBOutlet weak var purchasedAtLabel: UILabel!
    @IBOutlet weak var stockAnalayticsGraphHolderView: UIView!
    
    var stockPriceGraphPoints: [Float] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        getStockAnalytics(ticker: "MSFT")
    }
    
    private func getStockAnalytics(ticker: String) {
        let stockAnalyticsJSONUrl: String = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(ticker)&interval=15min&outputsize=full&apikey=demo"
        Alamofire.request(URL(string: stockAnalyticsJSONUrl)!, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let stockAnalyticJSON = JSON(value)["Time Series (15min)"]
                for (stockInfoAtTime):(String, JSON) in stockAnalyticJSON {
                    if let stockPrice = Float(stockInfoAtTime.1["4. close"].stringValue) {
                        self.stockPriceGraphPoints.insert(stockPrice, at: 0)
                    } else {
                        print("ERROR!: \(stockInfoAtTime.1["4. close"])")
                    }
                }
                let stockAnalayticsGraph = StockAnalyticsGraphView(graphPointsInit: self.stockPriceGraphPoints, frame: self.stockAnalayticsGraphHolderView.frame)
                self.view.addSubview(stockAnalayticsGraph)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initializeView() {
        stockPriceView.layer.cornerRadius = stockPriceView.frame.height / 2
        stockPriceView.layer.borderColor = UIColor.white.cgColor
        stockPriceView.layer.borderWidth = 1.0
    }

    

}
