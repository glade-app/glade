//
//  WelcomeViewController.swift
//  Glade
//
//  Created by Allen Gu on 2/14/21.
//

import UIKit

class WelcomeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var signUpButton: LoginSequenceButton!
    @IBOutlet weak var loginButton: LoginSequenceButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Background View
        backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
        
        // Slogan Label
        sloganLabel.text = "Connecting through music."
        sloganLabel.font = Fonts.getFont(type: .medium, size: 20)
        sloganLabel.textAlignment = .center
        
        // Button Stack
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 40
        
        // Sign Up Button
        signUpButton.titleLabel!.text = "Sign Up"
        signUpButton.setStyle(style: .normal)
        
        // Login Button
        loginButton.titleLabel!.text = "Log In"
        loginButton.setStyle(style: .unfilled)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "welcomeToSchools", sender: self)
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        performSegue(withIdentifier: "welcomeToLogin", sender: self)
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
