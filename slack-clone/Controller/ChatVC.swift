//
//  ChatVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 10/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)

                }
            })
        }
   }

    @objc func userDataDidChange(_ notify: Notification) {
        if AuthService.instance.isLoggedIn {
            // get channels
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.title ?? " "
        channelNameLabel.text = "#\(channelName)"
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {

            }
        }
    }
    
}
