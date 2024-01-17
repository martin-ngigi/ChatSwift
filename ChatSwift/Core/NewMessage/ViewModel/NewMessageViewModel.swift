//
//  NewMessageViewModel.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 17/01/2024.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]() // initialize empty array of users
    
    init(){
        Task { try await fetchUsers() }
    }
    
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != currentUid }) // filter all users except current user
    }
}
