//
//  ChatViewModel.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 17/01/2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]() // initialize empty arrey of messages
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
            print("DEBUG: All Messages are \(messages)")
        }
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}
