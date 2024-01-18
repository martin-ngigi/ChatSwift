//
//  InboxViewModel.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 17/01/2024.
//

import Foundation
import Combine // Help in passing data from Service to ViewModel
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]() // initialixe empty array of messages
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    
    init() {
        setupSubcribers()
        service.observeRecentMessages()
    }
    
    private func setupSubcribers(){
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables) // passing data from Service to this ViewModel using Combine
        
        service.$documentChages.sink { [weak self] changes in
            self?.loadIntitalMessages(fromChanges: changes)
        }.store(in: &cancellables)
     }
    
    private func loadIntitalMessages(fromChanges changes: [DocumentChange]) {
        
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
        
        print("DEBUG: InboxViewModel loadIntitalMessages Message Count: \(messages.count )")
        
        // Fetch user data and appaend
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}
