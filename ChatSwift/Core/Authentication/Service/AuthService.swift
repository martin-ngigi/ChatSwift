//
//  AuthService.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService() // This will unify the AuthService. i.e. we will have one instance of AuthService. rather than have multiple instances of AuthService
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task { try await UserService.shared.fetchCurrentUser()}
        print("DEBUG: User session id is \(userSession?.uid)")
    }
    
    @MainActor // pass thread from background thread to main thread
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        }
        catch {
            print("DEBU: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            print("DEBUG: Create user \(result.user.uid)")
        }
        catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut() // signout from firebase
            self.userSession = nil // updates routing logic i.e. clear user session
        }
        catch {
            print("DEBUG: failed to signout with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email: String, fullname: String, id: String) async throws{
        let user = User(fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return } // import FirebaseFirestoreSwift
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}
