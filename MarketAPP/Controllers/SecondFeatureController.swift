//
//  SecondFeatureController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol secondFeatureActivatedProtocol {
    func secondFeatureActivated()
}

class SecondFeatureController: UIViewController {

    var delegate: secondFeatureActivatedProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.secondFeatureActivated()
    }

}
