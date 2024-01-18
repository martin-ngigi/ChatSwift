//
//  ChatService.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 18/01/2024.
//

import Foundation
import Firebase

struct ChatService {
    
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document() // here we are using ".document()" , this will create new document with id
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId,
                              fromId: currentUid,
                              toId: chatPartnerId,
                              messageText: messageText,
                              timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        // actual messages
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        // recent message
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }
    
func observeMessages( completion: @escaping([Message]) -> Void) { // Completion Handler so that we can use addSnapshotListener which is real time as compared to async await which doesn't have addSnapshotListener
       guard let currentUid = Auth.auth().currentUser?.uid else { return }
       let chatPartnerId = chatPartner.id
        
       let query = FirestoreConstants.MessagesCollection
           .document(currentUid)
           .collection(chatPartnerId)
           .order(by: "timestamp", descending: false)
       
       print("Query message result: \(query)")
       
       query.addSnapshotListener { snapshot, error in
           if let error = error {
               print("DEBUG: ChatService, observeRecentMessages loading messages error \(error.localizedDescription)")
               return
           }
           
           guard let changes = snapshot?.documentChanges.filter({
               $0.type == .added
               //|| $0.type == .modified
               //|| $0.type == .removed
           })
           else { return } // " .added" This will load messages that were added and so on ...
           
           var messages = changes.compactMap({try? $0.document.data(as: Message.self)})
           
           for (index, message) in messages.enumerated() where message.fromId != currentUid {
               messages[index].user = chatPartner
           }
           print("addSnapshotListener messages result: \(messages)")

           completion(messages)
       }
        
    }
}
