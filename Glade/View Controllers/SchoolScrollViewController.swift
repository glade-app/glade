//
//  ScrollViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit
import FirebaseFirestore

class SchoolScrollViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let images = ["berkeley2", "stanford", "harvard"]
    let imageNames = ["UC Berkeley", "Stanford", "Harvard"]
    var schoolSelected: String?
    var lastCellIndexSelected: IndexPath?
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: LoginSequenceButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setGradientBackground(bottomColor: UIColor(red: 0/255, green: 161/255, blue: 255/255, alpha: 0.3), topColor: UIColor(red: 0/255, green: 255/255, blue: 143/255, alpha: 0.3))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
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
        
        // Choose your school prompt
        chooseLabel.text = "Choose your school:"
        //chooseLabel.textColor
        chooseLabel.font = UIFont.boldSystemFont(ofSize: 32)
        chooseLabel.textAlignment = .left
        chooseLabel.numberOfLines = 0
        
        // Collection View
        schoolCollectionView.backgroundColor = .clear
        schoolCollectionView.delaysContentTouches = false
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setInactive()
    }
    
    func registerNib() {
        let nib = UINib(nibName: SchoolCollectionViewCell.nibName, bundle: nil)
        schoolCollectionView?.register(nib, forCellWithReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier)
    }
    
    func setGradientBackground(bottomColor: UIColor, topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
        gradientLayer.shouldRasterize = true
        backgroundView.layer.addSublayer(gradientLayer)
    }
    
    // Returns number of rows (1)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Returns the number of images (schools)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // Creates cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = schoolCollectionView.dequeueReusableCell(withReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier, for: indexPath) as! SchoolCollectionViewCell
        let imageToDisplay = UIImage(named: images[indexPath.item])
        cell.configureCell(schoolName: imageNames[indexPath.item], image: imageToDisplay!)
        return cell
    }
    
    // Action on tap (currently prints the school name corresponding to the image)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageNames[indexPath.item])
        schoolSelected = imageNames[indexPath.item]
                
        if lastCellIndexSelected != nil {
            collectionView.deselectItem(at: lastCellIndexSelected!, animated: true)
        }
        lastCellIndexSelected = indexPath
        self.nextButton.setActive()
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
            lastCellIndexSelected = nil
            schoolSelected = nil
            collectionView.deselectItem(at: indexPath, animated: true)
            self.nextButton.setInactive()
            return false
        }
        return true
    }
    
    // Sets cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionCellWidth: CGFloat = collectionView.bounds.size.width * 2/3
        let collectionCellHeight: CGFloat = collectionView.bounds.size.height
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
    
    // Changes spacing between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
    // Not really sure what this does? Might change vertical spacing but probably won't be useful for us
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Changes the left and right end points of the collection view (where the cells start and end)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: collectionView.bounds.size.width * 1/8, bottom: 0, right: collectionView.bounds.size.width * 1/8)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if schoolSelected != nil {
            print("School Selected:", schoolSelected!)
            UserDefaults.standard.set(schoolSelected, forKey: "school")
            performSegue(withIdentifier: "toSpotifyConnect", sender: self)
        }
    }
}


