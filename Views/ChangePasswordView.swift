//
//  ChangePasswordView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/25/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    @State private var password = ""
    
    let user: User
    
    init(user: User) {
        
        self.user = user
        
    }
    
    var body: some View {
        
        
        Text("Update Password")
            .padding()
            .font(.system(size: 18))
            .bold()
        
        Form{
            
            if !viewModel.passwordErrorMessage.isEmpty{
                Text(viewModel.passwordErrorMessage)
                    .foregroundColor(Color.red)
                    .font(.footnote)
                    .bold()
            }
            
            TextField("New Password: ", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
            
            MButton(title: "Update Password", background: .blue, action: {viewModel.changePassword(password: password, user: user)})

            Text("You will be logged out upon password change")
                .font(.footnote)
            
        }
    }
}

//#Preview {
//    ChangePasswordView()
//}
