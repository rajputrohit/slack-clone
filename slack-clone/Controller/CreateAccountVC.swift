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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var avatarName: String = "profileDefault"
    var avatarColor: String = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                    userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    @IBAction func createAccountDidPress(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
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
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: TO_CHANNEL_VC , sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
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
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        UIView.animate(withDuration: 0.3) {
            self.userImage.backgroundColor = self.bgColor
        }
   
    }
    
    @IBAction func closeButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: TO_CHANNEL_VC, sender: nil)
    }
    
    func setupView() {
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: slackPurplePlaceholder])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: slackPurplePlaceholder])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: slackPurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        spinner.isHidden = true
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
}
















