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
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
            print("DEBUG: All Messages are \(messages)")
        }
    }
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
}
