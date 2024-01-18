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

                List {
                    //ForEach(0 ... 10, id: \.self) { message in
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                    
                    ForEach(viewModel.recentMessages) { message in
                        ZStack {// This Zstack will help in removing the chevron icon that is automatically added by apple in NavigationLink, since we already have our own chevron icon
                            NavigationLink(value: message) { // Naviage to Chat Page and pass message
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(message: message)

                        }
                        
                        
                    }
                }
            .listStyle(PlainListStyle())
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil // show chat only if newValue is not nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
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
