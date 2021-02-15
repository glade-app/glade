//
//  LoginViewController.swift
//  Glade
//
//  Created by Allen Gu on 2/14/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var emailTextField: LoginSequenceTextField!
    @IBOutlet weak var passwordTextField: LoginSequenceTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: LoginSequenceButton!
    @IBOutlet weak var signUpContainerView: UIView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setup() {
        // Background View
        backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
        
        // Prompt
        promptLabel.text = "Login to your account"
        promptLabel.numberOfLines = 0
        promptLabel.font = Fonts.getFont(type: .medium, size: 32)

        // Error Label
        errorLabel.isHidden = true
        errorLabel.font = Fonts.getFont(type: .regular, size: 14)
        
        // Text Fields
        emailTextField.attributedPlaceholder = NSAttributedString(string: "SCHOOL EMAIL", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        emailTextField.delegate = self
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        passwordTextField.delegate = self
        
        // Login Button
        loginButton.setActive()
        
        // Return to Sign Up
        signUpContainerView.backgroundColor = .clear
        signUpLabel.text = "Don't have an account?"
        signUpLabel.textAlignment = .right
        signUpLabel.font = Fonts.getFont(type: .regular, size: 17)
        signUpButton.titleLabel!.text = "Sign Up"
        signUpButton.titleLabel!.textAlignment = .left
        signUpButton.titleLabel!.font = Fonts.getFont(type: .bold, size: 17)
        signUpButton.titleLabel!.textColor = UIColor(red: 0/255, green: 0/255, blue: 238/255, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignup", sender: self)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // Auth here
        
        performSegue(withIdentifier: "loginToMain", sender: self)
    }
}
