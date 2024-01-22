//
//  ChatView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import SwiftUI

struct ChatView: View {
    
    //@State private var messageText = ""
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                //header
                VStack{
                    CircularImageProfileView(user: user, size: .xLarge)
                    
                    VStack (spacing: 4) {
                        
                        Text(user.fullname)
                            .font(.title3)
                        .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    

                }
                
                // messages
                LazyVStack{ // LazyVStack will render only needed messages. i.e. pagination
                    ForEach(viewModel.messages){ message in
                        ChatMessageCell(message: message)
                    }
                }
                
            }
            
            // message input view
            Spacer()
            
            ZStack (alignment: .trailing){
                
                TextField("Type message ... ", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    print("DEBUG: Send Button pressed")
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFill()
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationTitle(user.fullname)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
