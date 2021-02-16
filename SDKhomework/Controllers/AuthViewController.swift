//
//  ViewController.swift
//  SDKhomework
//
//  Created by Дарья on 12.02.2021.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class AuthViewController: UIViewController {
    
    var fullName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInGoogleButton()
        setupSignInFacebookButton()
    }
        
    private func setupSignInGoogleButton() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 32, y: 250, width: view.frame.width - 64, height: 50)
        view.addSubview(googleButton)
    }
    
    private func setupSignInFacebookButton(){
        
        let fbButton = FBLoginButton()
        fbButton.frame = CGRect(x: 32, y: 320, width: view.frame.width - 64, height: 40)
        view.addSubview(fbButton)
        
        fbButton.delegate = self
        
        if let token = AccessToken.current, !token.isExpired { // User is logged in, do work such as go to next view controller.
            print("Facebook: \(token)")
        }
        fbButton.permissions = ["public_profile", "email", "user_friends"]
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

//MARK: - FB LoginButtonDelegate

extension AuthViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error)
            return
        }
        
        guard AccessToken.isCurrentAccessTokenActive else { return }
        print("Successfully logged in with facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did log out of facebook")
    }
    
    
}
