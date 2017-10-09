//
//  LoginService.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class LoginService {
    
    static func loginErrors(error: Error, controller: UIViewController) {
        switch (error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmailAlert = UIAlertController(title: NSLocalizedString("Invalid Email", comment: "Invalid Email"), message:
                NSLocalizedString("It seems like you have put in an invalid email.", comment: "It seems like you have put in an invalid email."), preferredStyle: UIAlertControllerStyle.alert)
            invalidEmailAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmailAlert, animated: true, completion: nil)
            break;
        case "The password is invalid or the user does not have a password.":
            let wrongPasswordAlert = UIAlertController(title: NSLocalizedString("Wrong Password", comment: "Wrong Password"), message:
                NSLocalizedString("It seems like you have entered the wrong password.", comment: "It seems like you have entered the wrong password."), preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            let wrongPasswordAlert = UIAlertController(title: NSLocalizedString("No Account Found", comment: "No Account Found"), message:
                NSLocalizedString("We couldn't find an account that corresponds to that email. Do you want to create an account?", comment: "We couldn't find an account that corresponds to that email. Do you want to create an account?"), preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Create Account", comment: "Create Account"), style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                controller.performSegue(withIdentifier: "createAccountSegue", sender: nil)
            }))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        default:
            let loginFailedAlert = UIAlertController(title: NSLocalizedString("Error Logging In", comment: "Error Logging In"), message:
                "\(NSLocalizedString("There was an error logging you in. Please try again soon.", comment: "There was an error logging you in. Please try again soon.")) \n\nError: \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            loginFailedAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(loginFailedAlert, animated: true, completion: nil)
            break;
        }
    }
    
}