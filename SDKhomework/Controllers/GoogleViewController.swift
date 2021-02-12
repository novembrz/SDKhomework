//
//  GoogleViewController.swift
//  SDKhomework
//
//  Created by Дарья on 12.02.2021.
//

import UIKit
import GoogleSignIn

class GoogleViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name = self.name else {return}
        helloLabel.text = "Привет, \(name)"
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        print("Пользователь вышел из акканута")
        dismiss(animated: true, completion: nil)
    }
}
