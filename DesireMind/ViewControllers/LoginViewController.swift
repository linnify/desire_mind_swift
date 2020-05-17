//
//  LoginViewController.swift
//  DesireMind
//
//  Created by Vlad Rusu on 17/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton!) {
        print("I want to login")
        login()
    }
    
    private func login() {
        print("Will really login")
        
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            login()
        default:
            break
        }
        
        return true
    }
    
}
