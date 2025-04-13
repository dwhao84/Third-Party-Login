//
//  ViewController.swift
//  Third-Party-Login
//
//  Created by Dawei Hao on 2025/4/12.
//

import UIKit
import FacebookLogin
import FacebookCore
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var accountStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var reigsterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=== Login to View Controller ===")
        
        setupUI()
    }
    
    func setupUI () {
        print("=== setupUI ===")
        addTextFieldDelegates()
        setupTextFields()
        setupButtonsUI()
        addTapGestureRecognizer()
        addTargets()
        setupFacebookButton()
        setupAuthrorizationAppleIDButton()
        setupStackViews()
    }
    
    func addTargets () {
        print("=== add Targets ===")
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(fbLoginButtonClicked), for: .touchUpInside)
    }
    
    func setupStackViews () {
        print("=== setupStackViews ===")
        accountStackView.axis = .vertical
        accountStackView.spacing = 10
        accountStackView.distribution = .fill
        accountStackView.alignment = .fill
        
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 10
        passwordStackView.distribution = .fill
        passwordStackView.alignment = .fill
        
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fill
        buttonsStackView.alignment = .fill
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
    }
    
    func setupAuthrorizationAppleIDButton () {
        print("=== setup AuthrorizationAppleIDButton ===")
        let authorizationAppleIDButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton()
        authorizationAppleIDButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: UIControl.Event.touchUpInside)
        
        accountTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        accountTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        facebookButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        authorizationAppleIDButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        authorizationAppleIDButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reigsterButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        reigsterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        accountStackView.addArrangedSubview(accountLabel)
        accountStackView.addArrangedSubview(accountTextField)

        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        buttonsStackView.addArrangedSubview(facebookButton)
        buttonsStackView.addArrangedSubview(googleButton)
        buttonsStackView.addArrangedSubview(authorizationAppleIDButton)
        buttonsStackView.addArrangedSubview(reigsterButton)
        
        mainStackView.addArrangedSubview(accountStackView)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(buttonsStackView)
        
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func setupFacebookButton() {
        let facebookButton = FBLoginButton()                      // 設定facebook Button 為FBLoginButton()的類別。
        facebookButton.permissions = ["public_profile", "email"]  // 設定Persmissions
        accessToken()                                             // 加入access Token，確認是否有token，避免不必要的登入流程。
    }
    
    func setupTextFields () {
        print("=== setup TextFields ===")
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
    
    func setupButtonsUI () {
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor.lightGray.cgColor
        googleButton.layer.cornerRadius = 5
        googleButton.clipsToBounds = true
        googleButton.imageView?.image = UIImage(named: "google.png")
        
        facebookButton.layer.borderWidth = 1
        facebookButton.layer.borderColor = UIColor.lightGray.cgColor
        facebookButton.layer.cornerRadius = 5
        facebookButton.clipsToBounds = true
        facebookButton.imageView?.image = UIImage(named: "Image.png")
        facebookButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func addTapGestureRecognizer () {
        print("=== add Tap Gesture Recognizer ===")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - 確認是否有token
    func accessToken () {
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            print("=== token expired ===")
        }
        print("=== access Token ===")
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    // MARK: - 點擊facebook button
    @IBAction func fbLoginButtonClicked(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logIn(viewController: self, configuration: LoginConfiguration(
            permissions: ["public_profile", "email"],
            tracking: .enabled
            
        )) { result in
            switch result {
            case .success(let grantedPermissions, let declinedPermissions, _):
                print("=== success ===")
                print("=== Granted permissions: \(grantedPermissions)===")
                print("=== Declined permissions: \(declinedPermissions)===")
                // Handle successful login here
                
            case .cancelled:
                print("=== cancelled ===")
                // Handle user cancellation
                
            case .failed(let error):
                print("error: \(error)")
                // Handle login failure
            }
        }
    }
    
    // MARK: - 點擊googleButton
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        print("=== google Button Tapped ===")
        GIDSignIn.sharedInstance.signIn(withPresenting: self)
        
        print("=== GOOGLE SIGN-IN SUCCESS ===")
    }
    
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        print("=== hideKeyboard ===")
        view.endEditing(true)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        guard let viewController = self.presentingViewController as? FirstViewController
            else { return }
        
        DispatchQueue.main.async {
            viewController.welcomeLabel.text = userIdentifier
            if let givenName = fullName?.givenName {
                viewController.givenNameLabel.text = givenName
            }
            if let familyName = fullName?.familyName {
                viewController.familyNameLabel.text = familyName
            }
            if let email = email {
                viewController.emailLabel.text = email
            }
            self.dismiss(animated: true, completion: nil)
        }
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
