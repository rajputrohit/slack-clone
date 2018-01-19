//
//  ChannelVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 10/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if AuthService.instance.isLoggedIn {
//            NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
//        }
//    }
//
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL, for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func loginButtonDidPress(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // Show profile Modal Pop Up
            let profile = ProfileModalPopupVC()
            profile.modalPresentationStyle = .custom
            profile.modalTransitionStyle = .crossDissolve
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: self)
        }
    }
    
    
    
    @IBAction func unwindFromCreateAccountVC(segue: UIStoryboardSegue){
        
    }
    
    @objc func userDataDidChange(_ notify: Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named:(UserDataService.instance.avatarName))
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func addChannelButtonDidPress(_ sender: Any) {
        let addChannel = CreateChannelPopupVC()
        addChannel.modalPresentationStyle = .custom
        addChannel.modalTransitionStyle = .crossDissolve
        present(addChannel, animated: true, completion: nil)
    }
    
    
}
