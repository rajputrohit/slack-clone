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
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

// Colors
let slackPurplePlaceholder = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 0.5)

// Notification
let NOTIFY_USER_DATA_DID_CHANGE = Notification.Name(rawValue: "notifyUserDataDidChange")
let NOTIFY_CHANNELS_DID_LOAD = Notification.Name(rawValue: "channelsLoaded")
let NOTIFY_CHANNEL_SELECTED = Notification.Name(rawValue: "channelSelected")



// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccountVC"
let TO_CHANNEL_VC = "toChannelVC"
let TO_AVATAR_PICKER_VC = "toAvatarPickerVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Table Cells
let CHANNEL_CELL = "channelCell"
let MESSAGE_CELL = "messageCell"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER =  [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]







