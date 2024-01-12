//
//  RegistrationView.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 11/01/2024.
//

import SwiftUI

struct RegistrationView: View {
    
//    @State private var email = ""
//    @State private var password = ""
//    @State private var fullname = ""
    
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{ // We didn't wrap this in NavigationStack because thet Root View i.e. LoginView is already wrapped in NavigationStack
            Spacer()
            
            // logo image
            Image("messenger-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            // text fields
            VStack(spacing: 12){
                TextField("Enter your email", text: $viewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                
                TextField("Enter your fullname", text: $viewModel.fullname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                
                SecureField("Enter your password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
            }
            
            // register button
            Button{
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
            
            // Already have an account?
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RegistrationView()
}
