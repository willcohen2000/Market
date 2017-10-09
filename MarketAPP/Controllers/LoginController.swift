//
//  LoginController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let userEmail: String = emailTextField.text!
        let userPassword: String = passwordTextField.text!
        Auth.auth().signIn( withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if error == nil {
                KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "myStocksVC") as UIViewController
                self.present(vc, animated: true, completion: nil)
            } else {
                if let error = error {
                    LoginService.loginErrors(error: error, controller: self)
                }
            }
        })
    }
    
    @IBAction func returnToHomePageButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
