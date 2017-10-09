//
//  SignupService.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class SignupService {
    
    static func signUpErrors(error: Error, controller: UIViewController) {
        switch(error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmail = UIAlertController(title: NSLocalizedString("Email is not properly formatted.", comment: "Email is not properly formatted."), message:
                NSLocalizedString("Please enter a valid email to sign up with.", comment: "Please enter a valid email to sign up with."), preferredStyle: UIAlertControllerStyle.alert)
            invalidEmail.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmail, animated: true, completion: nil)
            break;
        default:
            let generalErrorAlert = UIAlertController(title: NSLocalizedString("We are having trouble signing you up.", comment: "We are having trouble signing you up."), message:
                "\(NSLocalizedString("We are having trouble signing you up, please try again soon.", comment: "We are having trouble signing you up, please try again soon.")) \n\nError: \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            generalErrorAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(generalErrorAlert, animated: true, completion: nil)
            break;
        }
    }
    
}
