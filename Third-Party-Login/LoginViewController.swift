//
//  ViewController.swift
//  Third-Party-Login
//
//  Created by Dawei Hao on 2025/4/12.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var reigsterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Login to View Controller")
        
    }
    
    func setupUI () {
        print("=== setupUI ===")
        addTextFieldDelegates()
        setupTextFields()
    }
    
    func setupTextFields () {
        print("setup TextFields")
        accountTextField.keyboardType = .default
        passwordTextField.keyboardType = .default
        
        accountTextField.clearButtonMode = .whileEditing
        passwordTextField.clearButtonMode = .whileEditing
    }

    func addTextFieldDelegates () {
        print("=== add TextField Delegates ===")
        accountTextField.delegate = self
        passwordTextField.delegate = self
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("=== textFieldShouldReturn ===")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        print("=== textFieldDidBeginEditing ===")
    }
}
