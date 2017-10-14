//
//  StockAnalyticsController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/14/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class StockAnalyticsController: UIViewController {

    @IBOutlet weak var stockPriceView: UIView!
    @IBOutlet weak var percentReturnLabel: UILabel!
    @IBOutlet weak var dollarReturnLabel: UILabel!
    @IBOutlet weak var openedTodayLabel: UILabel!
    @IBOutlet weak var purchasedAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    private func initializeView() {
        stockPriceView.layer.cornerRadius = stockPriceView.frame.height / 2
        stockPriceView.layer.borderColor = UIColor.white.cgColor
        stockPriceView.layer.borderWidth = 1.0
    }

    

}
