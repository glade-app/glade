//
//  SocialsViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class SocialsViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var socialsPromptLabel: UILabel!
    @IBOutlet weak var facebookStack: UIStackView!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var facebookField: LoginSequenceTextField!
    @IBOutlet weak var instagramStack: UIStackView!
    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var instagramField: LoginSequenceTextField!
    @IBOutlet weak var snapchatStack: UIStackView!
    @IBOutlet weak var snapchatImage: UIImageView!
    @IBOutlet weak var snapchatField: LoginSequenceTextField!
    @IBOutlet weak var nextButton: LoginSequenceButton!
    
    var userData: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setGradientBackground(bottomColor: UIColor(red: 0/255, green: 161/255, blue: 255/255, alpha: 0.3), topColor: UIColor(red: 0/255, green: 255/255, blue: 143/255, alpha: 0.3))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupItems() {
        // Glade
        gladeNameLabel.text = "Glade"
        //gladeNameLabel.textColor
        gladeNameLabel.font = UIFont.boldSystemFont(ofSize: 72)
        gladeNameLabel.textAlignment = .center
        gladeNameLabel.numberOfLines = 0
        
        facebookImage.image = UIImage(named: "facebook")
        instagramImage.image = UIImage(named: "instagram")
        snapchatImage.image = UIImage(named: "snapchat")

        // Vertical stack
        verticalStack.spacing = 20
        verticalStack.alignment = .center
        verticalStack.distribution = .fill
        
        
        // Socials prompt
        socialsPromptLabel.text = "Connect your socials:"
        //emailPromptLabel.textColor
        socialsPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        socialsPromptLabel.textAlignment = .left
        socialsPromptLabel.numberOfLines = 0
        
        // Facebook stack
        facebookStack.spacing = 10
        self.facebookField.delegate = self
        
        // Instagram stack
        instagramStack.spacing = 10
        self.instagramField.delegate = self

        // Snapchat stack
        snapchatStack.spacing = 10
        self.snapchatField.delegate = self

        // Next Button
        nextButton.setTitle("Sign Up", for: .normal)
    }
    
    func setGradientBackground(bottomColor: UIColor, topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
        gradientLayer.shouldRasterize = true
        backgroundView.layer.addSublayer(gradientLayer)
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        facebookField.resignFirstResponder()
        instagramField.resignFirstResponder()
        snapchatField.resignFirstResponder()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        DataStorage.updateUserFields(username: username!,
            fields: ["socials": ["snapchat": snapchatField.text,
                                 "facebook": facebookField.text,
                                 "instagram": instagramField.text]]) { (result) in
            return
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "signedUp")
        performSegue(withIdentifier: "signupToMain", sender: self)
    }
}
