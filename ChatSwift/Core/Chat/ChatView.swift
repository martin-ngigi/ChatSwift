//
//  ChatView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import SwiftUI

struct ChatView: View {
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                //header
                VStack{
                    CircularImageProfileView(user: User.MOCK_USER, size: .xLarge)
                    
                    VStack (spacing: 4) {
                        
                        Text("Martin Wainaina")
                            .font(.title3)
                        .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    

                }
                
                // messages
                ForEach(0 ... 15, id: \.self){ message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
                
            }
            
            // message input view
            Spacer()
            
            ZStack (alignment: .trailing){
                
                TextField("Type message ... ", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    print("DEBUG: Send Button pressed")
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFill()
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
