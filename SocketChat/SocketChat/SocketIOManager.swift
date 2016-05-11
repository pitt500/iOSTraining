//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by projas on 5/10/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.30.161:3000")!)
    
    override init(){
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func connectToServerWithNickname(nickname: String, completionHandler: (userList:[[String: AnyObject]]!) -> Void) {
        socket.emit("connectUser", nickname)
        
        socket.on("userList") { (dataArray, ack) in
            completionHandler(userList: dataArray[0] as![[String: AnyObject]])
        }
        
        listenForOtherMessages()
    }
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    func getChatMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String
            messageDictionary["message"] = dataArray[1] as! String
            messageDictionary["date"] = dataArray[2] as! String
            
            completionHandler(messageInfo: messageDictionary)
        }
    }
    
    private func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) in
            let userData = dataArray[0] as! [String: AnyObject]
            NSNotificationCenter.defaultCenter().postNotificationName("userWasConnectedNotification", object: userData)
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) in
            let nickname = dataArray[0] as! String
            NSNotificationCenter.defaultCenter().postNotificationName("userWasDisconnectedNotification", object: nickname)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) in
            let usersTyping = dataArray[0] as? [String: AnyObject]
            NSNotificationCenter.defaultCenter().postNotificationName("userTypingNotification", object: usersTyping)
        }

    }
    
    func sendStartTypingMessage(nickname: String) {
        socket.emit("startType", nickname)
    }
    
    func sendStopTypingMessage(nickname: String) {
        socket.emit("stopType", nickname)
    }
    
    
}
