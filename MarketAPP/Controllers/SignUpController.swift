//
//  SignUpController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let userPassword: String = passwordTextField.text else { return }
        guard let userEmail: String = emailTextField.text else { return }
        
        if (passwordTextField.text != confirmPasswordTextField.text) {
            let passwordsDontMatchAlert = UIAlertController(title: NSLocalizedString("Passwords Do Not Match", comment: "Passwords Do Not Match"), message:
                NSLocalizedString("It seems like you have entered in two different passwords.", comment: "It seems like you have entered in two different passwords."), preferredStyle: UIAlertControllerStyle.alert)
            passwordsDontMatchAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(passwordsDontMatchAlert, animated: true, completion: nil)
        } else if userPassword.characters.count < 6 {
            FunctionService.createSimpleAlert(alertTitle: NSLocalizedString("Password too short.", comment: "Password too short."), alertMessage: NSLocalizedString("Passwords must contain at least six characters.", comment: "Passwords must contain at least six characters."), controller: self)
        } else {
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
                if let error = error {
                    SignupService.signUpErrors(error: error, controller: self)
                    return
                } else {
                    KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                    let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let vc = homeStoryboard.instantiateViewController(withIdentifier: "myStocksVC") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func returnToHomePageButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
