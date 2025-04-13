//
//  FirstViewController.swift
//  Third-Party-Login
//
//  Created by Dawei Hao on 2025/4/12.
//

import UIKit
import FacebookLogin
import FacebookCore

class FirstViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var givenNameLabel: UILabel!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("=== FirstViewController ===")
    }

    
    
}
