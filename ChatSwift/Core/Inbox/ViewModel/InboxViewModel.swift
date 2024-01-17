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
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        setupSubcribers()
    }
    
    private func setupSubcribers(){
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
     }
}
