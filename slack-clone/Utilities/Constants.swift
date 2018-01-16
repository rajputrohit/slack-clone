//
//  Constants.swift
//  slack-clone
//
//  Created by Rohit Rajput on 12/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> () // after = is a closure

// URL Constants
let BASE_URL = "https://slack-clone-1.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"


// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccountVC"
let TO_CHANNEL_VC = "toChannelVC"
let TO_AVATAR_PICKER_VC = "toAvatarPickerVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]







