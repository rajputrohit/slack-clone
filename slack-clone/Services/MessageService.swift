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
    
}


