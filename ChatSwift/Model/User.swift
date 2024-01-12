//
//  User.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    let profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullname: "Mock User", email: "mockuser@gmail.com", profileImageUrl: "person")
}
