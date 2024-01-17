//
//  User.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    let profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Mock User", email: "mockuser@gmail.com", profileImageUrl: "person")
}
