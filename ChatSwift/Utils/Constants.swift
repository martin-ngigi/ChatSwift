//
//  Constants.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 18/01/2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")

}
