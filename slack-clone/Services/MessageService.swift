//
//  MessageService.swift
//  slack-clone
//
//  Created by Rohit Rajput on 19/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                //                do {
                //                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                //                } catch let error {
                //                    debugPrint(error)
                //                }
                //                print(self.channels)
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(title: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIFY_CHANNELS_DID_LOAD, object: nil)
                        completion(true)
                    }
                } catch {
                    debugPrint(response.error.debugDescription)
                }
            } else {
                completion(false)
                debugPrint(response.error.debugDescription)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func findAllMessagesForChannel(id: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let username = item["username"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, usename: username, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        completion(true)
                        print("Messages retrieving: \(self.messages)")
                    }
                }   catch {
                    
                }
            } else {
            debugPrint(response.result.error as Any)
            completion(false)
        }
    }
}

func clearMessages() {
    messages.removeAll()
}


}

















