//
//  SchoolCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit


class SchoolCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return "SchoolCollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "SchoolCollectionViewCell"
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.borderColor = UIColor(red: 0/255, green: 255/255, blue: 178/255, alpha: 1).cgColor
        
        self.containerView.backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        willSet {
            super.isSelected = newValue
            if newValue {
                self.imageView.layer.borderWidth = 3
            }
            else {
                self.imageView.layer.borderWidth = 0
            }
        }
    }
    
    func configureCell(schoolName: String, image: UIImage) {
        schoolLabel.text = schoolName
        imageView.image = image
    }

}
