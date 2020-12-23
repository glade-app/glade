//
//  EditProfileViewController.swift
//  Glade
//
//  Created by Allen Gu on 12/23/20.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var user: User?
    var profileVC: ProfileViewController?
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var snapchatImage: UIImageView!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var instagramTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.loadUserData()
    }
    
    func setup() {
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.width / 2
        self.profilePicture.layer.masksToBounds = true
        self.facebookImage.image = UIImage(named: "facebook")
        self.instagramImage.image = UIImage(named: "instagram")
        self.snapchatImage.image = UIImage(named: "snapchat")
    }
    
    func loadUserData() {
        let profilePictureUrl = self.user!.images?[0].url ?? ""
        if profilePictureUrl != "" {
            let profilePictureUrlObj = URL(string: profilePictureUrl)
            self.profilePicture.kf.setImage(with: profilePictureUrlObj)
        }
        self.nameTextField.text = self.user!.displayName ?? ""
        self.descriptionTextView.text = self.user!.description ?? ""
        self.facebookTextField.text = self.user!.socials?["facebook"] ?? ""
        self.snapchatTextField.text = self.user!.socials?["snapchat"] ?? ""
        self.instagramTextField.text = self.user!.socials?["instagram"] ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        self.descriptionTextView.resignFirstResponder()
        self.facebookTextField.resignFirstResponder()
        self.instagramTextField.resignFirstResponder()
        self.snapchatTextField.resignFirstResponder()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
    
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        self.user!.displayName = self.nameTextField.text
        self.user!.description = self.descriptionTextView.text
        self.user!.socials!["facebook"] = self.facebookTextField.text
        self.user!.socials!["snapchat"] = self.snapchatTextField.text
        self.user!.socials!["instagram"] = self.instagramTextField.text
        self.profileVC!.user = self.user!
        
        DataStorage.updateUserFields(username: self.user!.id!,
                                     fields: ["display_name": self.user!.displayName!,
                                              "description": self.user!.description!,
                                              "socials": self.user!.socials!]) { (result) in
            print("done")
        }
    }
}
