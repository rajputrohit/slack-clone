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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @IBAction func loginButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
    
    @IBAction func unwindFromCreateAccountVC(segue: UIStoryboardSegue){
        
    }
    
}
