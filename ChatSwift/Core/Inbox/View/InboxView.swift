//
//  InboxView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 11/01/2024.
//

import SwiftUI

struct InboxView: View {
    
    @State private var showNewMessageView = false
//    @State private var user = User.MOCK_USER
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack{
            ScrollView { // We used Scrollview here because Scrollview has additional features such as swipe
                ActiveNowView()
                
                List {
                    //ForEach(0 ... 10, id: \.self) { message in
                    ForEach(viewModel.recentMessages) { message in
                        InboxRowView(message: message)
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil // show chat only if newValue is not nil
            })
            .navigationDestination(for: User.self, destination: { user in
                ProfileView( user: user)
            })
            .navigationDestination(isPresented: $showChat, destination: {
                // Navigate to ChatView() from InboxView only after selecting User
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: { // This shows new message UI
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar{ // TopBar menu with profilePic, Chats,
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        // NavigationLink with value and label, this will help us pass the user object to the next page i.e. ProfileView Page. Also add .navigationDestination(){}
                        NavigationLink(value: user) {
//                            Image(user.profileImageUrl ?? "person")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 32, height: 32)
//                                .clipShape(Circle())
                            CircularImageProfileView(user: user, size: .xSmall)
                        }
                        
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("DEBUG: Show message view")
                        showNewMessageView.toggle()
                        selectedUser = nil // wipe out the new selected user
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
