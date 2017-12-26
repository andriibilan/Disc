//
//  TouchIDViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/16/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
import LocalAuthentication
class TouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         TouchID () 
    }
    
    func TouchID () {
        /// Create an authentication context
        let authenticationContext = LAContext()
        
        /// Check if device has a touch id sensor
        var touchIdNotFoundError: NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &touchIdNotFoundError) {
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need your Touch ID", reply: { (success,error) in
                if success {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showMain", sender: self)
                    }
                } else {
                    if let error = error as NSError? {
                        switch error.code {
                        case LAError.userCancel.rawValue:
                            exit(0)
                        case LAError.userFallback.rawValue:
                            self.password()
                        default:
                            break
                        }
                    }
                    self.password()
                }
            })
        } else {
            password()
        }
    }

    func password() {
        let password = "qwerty"
        let alertController = UIAlertController(title: "Password", message: "Please enter a password", preferredStyle: .alert)
        DispatchQueue.main.async {
            alertController.addTextField { (textfield) in
                textfield.text = ""
                textfield.isSecureTextEntry = true}
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction) in exit(0)}))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction) in
            let passwordADD = alertController.textFields![0]
            if  password == passwordADD.text {
                self.performSegue(withIdentifier: "showMain", sender: self)
            } else {
                exit(0)
            }
        }))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
