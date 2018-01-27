//
//  Message.swift
//  slack-clone
//
//  Created by Rohit Rajput on 21/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import Foundation

struct Message {
    public private(set) var message: String!
    public private(set) var username: String!
    public private(set) var channelId: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var id: String!
    public private(set) var timeStamp: String!
}
