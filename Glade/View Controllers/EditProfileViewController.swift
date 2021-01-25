//
//  EditProfileViewController.swift
//  Glade
//
//  Created by Allen Gu on 12/23/20.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User?
    var profileVC: ProfileViewController?
    var imagePicker = UIImagePickerController()
    
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
        self.profilePicture.isUserInteractionEnabled = true
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped(tapGestureRecognizer:)))
        self.profilePicture.addGestureRecognizer(profileTapGestureRecognizer)
        
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
    
    @objc func profilePictureTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("tapped profile")
        let alert = UIAlertController(title: "Choose Profile Picture", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Choose from Photo Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraFlashMode = .off
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.profilePicture.image = image
            DataStorage.storeUserImage(image: image) { (url) in
                if (url != nil) {
                    self.user!.images![0].url = url!.absoluteString
                }
                picker.dismiss(animated: true, completion: nil)
            }
        }
        else {
            picker.dismiss(animated: true, completion: nil)
        }
        
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
        
        DataStorage.updateUser(user: self.user!) { (result) in
            print("Finished Editing")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
