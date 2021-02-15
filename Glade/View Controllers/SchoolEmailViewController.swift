//
//  SchoolEmailViewController.swift
//  Glade
//
//  Created by Allen Gu on 2/14/21.
//

import UIKit

class SchoolEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var emailTextField: LoginSequenceTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: LoginSequenceButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Background
        backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
        
        // Prompt
        promptLabel.text = "Enter your school email address"
        promptLabel.font = Fonts.getFont(type: .medium, size: 32)
        promptLabel.numberOfLines = 0

        // Email Text Field
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        emailTextField.delegate = self
        
        // Error Label
        errorLabel.text = "Email not valid"
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        // Next Button
        nextButton.titleLabel!.text = "Next"
        nextButton.setActive()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let email: String = emailTextField.text!
        let school: String? = UserDefaults.standard.string(forKey: "school")
        if (school != nil) {
            if (EmailValidation.validateEmail(school: school!, email: email)) {
                hideErrorLabel()
                performSegue(withIdentifier: "schoolEmailToSpotifyConnect", sender: self)
            }
            else {
                displayErrorLabel()
                print("Email invalid")
            }
        }
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func displayErrorLabel() {
        errorLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        emailTextField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
