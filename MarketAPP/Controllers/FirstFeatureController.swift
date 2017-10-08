//
//  FirstFeatureController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol firstFeatureActivatedProtocol {
    func firstFeatureActivated()
}

class FirstFeatureController: UIViewController {

    var delegate: firstFeatureActivatedProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.firstFeatureActivated()
    }

}
