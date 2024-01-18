//
//  InboxRowView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 11/01/2024.
//

import SwiftUI

struct InboxRowView: View {
    let message: Message
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            
            //Person pic
            CircularImageProfileView(user: message.user, size: .medium)
            
            VStack (alignment: .leading, spacing: 4) {
                // Person name
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                // Person's text message.
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}

#Preview {
    InboxRowView(message: Message.MOCK_MESSAGE)
}
