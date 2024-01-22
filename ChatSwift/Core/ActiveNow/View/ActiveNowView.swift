//
//  ActiveNowView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 11/01/2024.
//

import SwiftUI

struct ActiveNowView: View {
    
    @StateObject var viewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack (spacing: 32) {
               // ForEach( 0 ... 10, id: \.self) { user in
                ForEach(viewModel.users) { user in
                    
                    NavigationLink(value: Route.chatView(user)) {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                
                                CircularImageProfileView(user: User.MOCK_USER, size: .medium)
                                
                                ZStack{
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                            }
                            
                            Text(user.firstName)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

#Preview {
    ActiveNowView()
}
