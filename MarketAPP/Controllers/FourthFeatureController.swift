//
//  FourthFeatureController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol fourthFeatureActivatedProtocol {
    func fourthFeatureActivated()
}

class FourthFeatureController: UIViewController {

    var delegate: fourthFeatureActivatedProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.fourthFeatureActivated()
    }

}
