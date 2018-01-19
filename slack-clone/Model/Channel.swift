//
//  Channel.swift
//  slack-clone
//
//  Created by Rohit Rajput on 19/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int!
}
