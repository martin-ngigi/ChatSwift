//
//  InboxService.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 18/01/2024.
//

import Foundation
import Firebase


class InboxService {
    @Published var documentChages = [DocumentChange]()
    
    func observeRecentMessages(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: InboxService, observeRecentMessages loading recent messages error \(error.localizedDescription)")
                return
            }
            
            self.documentChages = [DocumentChange]() // clear documentChages

            guard let changes = snapshot?.documentChanges.filter({ 
                $0.type == .added
                || $0.type == .modified
                //|| $0.type == .removed
            })
            else { return }
            
            self.documentChages = changes
            
        }
    }
}
