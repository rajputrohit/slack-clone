//
//  SocketService.swift
//  slack-clone
//
//  Created by Rohit Rajput on 20/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static var instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion:  @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            let newChannel = Channel(title: channelName, channelDescription: channelDescription, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userID: String, ChannelID: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userID, ChannelID, user.name, user.avatarName, user.avatarColor)
        completion(true)
        print(messageBody)
    }
    
    func getChatMessages(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            guard let username = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let messsageID = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            if channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: messageBody, username: username, channelId: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: messsageID, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void)  {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
    
    
}



















