//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit

class SpotifyConnectViewController: UIViewController, SPTSessionManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var connectLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var spotifyImage: UIImageView!
    @IBOutlet var connectButton: LoginSequenceButton!
        
    var configuration = SPTConfiguration(clientID: Constants.clientID, redirectURL: Constants.redirectURI)
    var didConnect: Bool = false
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = Constants.tokenSwapURL,
           let tokenRefreshURL = Constants.tokenRefreshURL {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
          // self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self)
        SceneDelegate.spotifyConnectVC = self // Tells SceneDelegate to return to this view controller after Spotify initiates a session

        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupItems() {
        // Connect Label
        connectLabel.font = Fonts.getFont(type: .medium, size: 32)
        
        // Connect Button
        connectButton.setTitle("Connect to Spotify", for: .normal)
        connectButton.setActive()
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Successfully created Spotify session:", session)

        // Request account info
        print("\nAccount Info Request...")
        let spotifyAccessToken = session.accessToken
        let spotifyRefreshToken = session.refreshToken
        
        Spotify.getUserData(accessToken: spotifyAccessToken) { (result, user) in
            DataStorage.storeUserData(user: user) { result in
                // Store tokens to Keychain
                let username = user.id!
                try? Token.setToken(spotifyAccessToken, "accessToken", username: username)
                try? Token.setToken(spotifyRefreshToken, "refreshToken", username: username)
                
                // Store artists and songs data to Firestore
                let group = DispatchGroup()
                let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".datastorage.queue", attributes: .concurrent)
                
                // Request user's top artists from Spotify and save to Firebase
                group.enter()
                queue.async {
                    Spotify.getUserTopArtists(accessToken: spotifyAccessToken) { (result, artists) in
                        DataStorage.storeUserTopArtists(artists: artists) { (result) in
                            print("Finished storing top artists")
                            group.leave()
                        }
                    }
                }
        
                // Request user's top songs from Spotify and save to Firebase
                group.enter()
                queue.async(group: group) {
                    Spotify.getUserTopSongs(accessToken: spotifyAccessToken) { (result, songs) in
                        DataStorage.storeUserTopSongs(songs: songs) { (result) in
                            print("Finished storing top songs")
                            group.leave()
                        }
                    }
                }
        
                group.notify(queue: .main) {
                    DispatchQueue.main.async {
                        self.didConnect = false // If user returns to this view controller, they can choose to connect again
                        self.performSegue(withIdentifier: "toDescription", sender: self)
                    }
                    print("Finished storing data to Firestore")
                }
            }
        }
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed with Error:", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renewed", session)
    }
    
    @IBAction func connectButtonTapped(_ sender: Any) {
        if didConnect {
            return
        }
        didConnect = true
        let scopes: SPTScope = [.userReadEmail, .userTopRead]
        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sessionManager.initiateSession(with: scopes, options: .default)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
            sessionManager.initiateSession(with: scopes, options: .clientOnly, presenting: self)
        }
    }
}
