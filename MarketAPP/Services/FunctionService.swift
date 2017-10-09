//
//  FunctionService.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class FunctionService {
    
    static func createSimpleAlert(alertTitle: String, alertMessage: String, controller: UIViewController) {
        let alert = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
}
