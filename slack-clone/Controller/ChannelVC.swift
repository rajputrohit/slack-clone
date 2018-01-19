//
//  ChannelVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 10/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @IBAction func loginButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
    
    @IBAction func unwindFromCreateAccountVC(segue: UIStoryboardSegue){
        
    }
    
    @objc func userDataDidChange(_ notify: Notification) {
        if (AuthService.instance.isLoggedIn) == true {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named:(UserDataService.instance.avatarName))
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
}
