//
//  ViewController.swift
//  SDKhomework
//
//  Created by Дарья on 12.02.2021.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    var fullName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInGoogleButton()
    }
    
    private func setupSignInGoogleButton() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        let googleButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        googleButton.center = view.center
        view.addSubview(googleButton)
    }
    
    //MARK: Navigation
    
    private func openMainViewController() {
        performSegue(withIdentifier: "googleSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "googleSegue" {
            guard let googleVC = segue.destination as? GoogleViewController else {return}
            googleVC.name = fullName
        }
    }
}

//MARK: - GIDSignInDelegate

extension AuthViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("Google: \(error.localizedDescription)")
            }
            return
        }
        /*
         let userId = user.userID,                // For client-side use only!
         let idToken = user.authentication.idToken, // Safe to send to the server
         */
        guard let fullName = user.profile.name else {return}
        self.fullName = fullName
        
        print("Google success: \(fullName)")
        openMainViewController()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("Google didDisconnectWith: \(error.localizedDescription)")
    }
}

