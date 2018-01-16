//
//  CreateAccountVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 12/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    // Variables
    var avatarName: String = "profileDefault"
    var avatarColor: String = "[0.5, 0.5, 0.5, 1]"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    
    @IBAction func createAccountDidPress(_ sender: Any) {
        guard  let userName = usernameTextField.text, usernameTextField.text != "" else {
            return
        }
        guard  let email = emailTextField.text, emailTextField.text != "" else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            return
        }
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered user!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("Logged in user!", "Token : \(AuthService.instance.authToken)")
                        
                        AuthService.instance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name,
                                      UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: TO_CHANNEL_VC , sender: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func chooseAvatarDidPress(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER_VC, sender: nil)
   
    }
    
    @IBAction func pickBackgroundColorDidPress(_ sender: Any) {
   
    }
    
    @IBAction func closeButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: TO_CHANNEL_VC, sender: nil)
    }
}
