//
//  ChatMessageCell.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 12/01/2024.
//

import SwiftUI

struct ChatMessageCell: View {
    
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer() // Push to right
                
                Text("This is a test message for nor")
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            }
            else {
                HStack (alignment: .bottom, spacing: 8) {
                    CircularImageProfileView(user: User.MOCK_USER, size: .xxSmall)
                    
                    Text("This is a test message for nor. This is a longer message. Lets see what happens.")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer() // Push to left
                }
            }
        }.padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: false)
}
