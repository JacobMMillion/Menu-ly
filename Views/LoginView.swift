//
//  LoginView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//


// User -> Menus


import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                // Header
                VStack{
                    Image("Menuly-logos")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 175, height: 175)
                        .padding(.top, 25)
                    
                    
                    Text("Providing informed service")
                        .font(.system(size:18))
                        .bold()
                        .italic()
                }
                
                
                // Login Form
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    Text("Login:")
                        .font(.system(size:15))
                        .bold()
                    
                    TextField("Email Address: ", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                    
                    SecureField("Password: ", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    MButton(title: "Log In", background: .blue, action: {viewModel.login()})
                    
                    NavigationLink("Forgot Password?", destination: ResetEmailView())
                        .font(.system(size:15))
                        .bold()
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                // Create Account
                VStack{
                    Text("New Around Here?")
                    NavigationLink("Register A New Account", destination: RegisterView())
                        .bold()
                    
                }
                
                Spacer()
                
            }
        }

    }
}

#Preview {
    LoginView()
}
