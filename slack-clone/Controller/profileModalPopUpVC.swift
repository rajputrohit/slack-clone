//
//  profileModalPopUpVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 19/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class profileModalPopUpVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var popUpView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func closeModalDidPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonDidPress(_ sender: Any) {
        UserDataService.instance.logoutUser()
        
        NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        popUpView.layer.cornerRadius = 20
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userName.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_ :)))
        backgroundView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}








