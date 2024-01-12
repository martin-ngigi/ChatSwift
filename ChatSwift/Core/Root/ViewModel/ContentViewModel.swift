//
//  ContentViewModel.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import Firebase
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        setupSubScribers()
    }
    
    private func setupSubScribers() {
        // listens for updates when user session changes values and store
        AuthService().$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancelables)
    }
}
