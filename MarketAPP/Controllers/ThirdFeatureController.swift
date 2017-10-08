//
//  ThirdFeatureController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol thirdFeatureActivatedProtocol {
    func thirdFeatureActivated()
}

class ThirdFeatureController: UIViewController {

    var delegate: thirdFeatureActivatedProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.thirdFeatureActivated()
    }

}
