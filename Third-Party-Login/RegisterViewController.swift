//
//  RegisterViewController.swift
//  Third-Party-Login
//
//  Created by Dawei Hao on 2025/4/12.
//

import UIKit
import FacebookLogin
import FacebookCore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var accountStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var secPasswordStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var secondPasswordLabel: UILabel!
    @IBOutlet weak var secondPasswordTextField: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("=== RegisterViewController ===")
    }

}
