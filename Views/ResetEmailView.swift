//
//  ResetEmailView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 3/14/24.
//

import SwiftUI

struct ResetEmailView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        
        Form{
            
            Text("Enter email below:")
                .bold()
            
            TextField("Email Address: ", text: $viewModel.resetEmail)
            
            MButton(title: "Send Reset Email", background: .red, action: {viewModel.reset()})
            
            Text(viewModel.resetMessage)
                .bold()
                .foregroundColor(Color.blue)
            
        }
    }
}

//#Preview {
//    ResetEmailView()
//}
