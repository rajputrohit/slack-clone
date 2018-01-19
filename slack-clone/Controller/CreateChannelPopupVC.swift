//
//  CreateChannelPopupVC.swift
//  slack-clone
//
//  Created by Rohit Rajput on 19/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit

class CreateChannelPopupVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeButtonDidPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelButtonDidPress(_ sender: Any) {
    }
    
    func setupView() {
        popupView.layer.cornerRadius = 20
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: slackPurplePlaceholder])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: slackPurplePlaceholder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
