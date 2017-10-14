//
//  MyStocksController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/9/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MyStocksController: UIViewController {

    @IBOutlet weak var allStocksSelectedImageView: UIImageView!
    @IBOutlet weak var shortStocksSelectedImageView: UIImageView!
    @IBOutlet weak var longStocksSelectedImageView: UIImageView!
    @IBOutlet weak var myStocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStocksTableView.delegate = self
        myStocksTableView.dataSource = self
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 0.0
    }
    
    @IBAction func allStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 0
        allStocksSelectedImageView.alpha = 100.0
    }
    
    @IBAction func shortStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 0.0
        shortStocksSelectedImageView.alpha = 100.0
        allStocksSelectedImageView.alpha = 0.0
    }
    
    @IBAction func longStockTypeButtonPressed(_ sender: Any) {
        longStocksSelectedImageView.alpha = 100.0
        shortStocksSelectedImageView.alpha = 0.0
        allStocksSelectedImageView.alpha = 0.0
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let stock = optionsArr[indexPath.row]
        if let stockCell = myStocksTableView.dequeueReusableCell(withIdentifier: "stockCell") as? MyStocksCell {
            stockCell.delegate = self
            stockCell.backgroundColor = UIColor.clear
            return stockCell
        } else {
            return MyStocksCell()
        }
    }
    
}


