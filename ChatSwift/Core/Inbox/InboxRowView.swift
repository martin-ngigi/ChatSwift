//
//  InboxRowView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 11/01/2024.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            
            //Person pic
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color(.systemGray4))
            
            VStack (alignment: .leading, spacing: 4) {
                // Person name
                Text("Martin Wainaina")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                // Person's text message.
                Text("Some test message for now and some later and later. And spans more than one line here.")
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
    InboxRowView()
}
