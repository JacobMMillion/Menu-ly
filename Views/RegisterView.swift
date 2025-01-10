//
//  RegisterView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    @State var showInfo: Bool = false
    
    var body: some View {

        VStack{
            VStack{
                Image("Menuly-logos")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175)
                    .padding(.top, 10)
                
                
                Text("Register a new account")
                    .font(.system(size:18))
                    .bold()
                    .italic()
            }
            
            
            Form{
                
                if !viewModel.errorMessage.isEmpty{
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                
                Text("Create an account:")
                    .font(.system(size:18))
                    .bold()
                
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                Toggle("Register as Administration", isOn: $viewModel.isAdmin)
                
                if !viewModel.isAdmin{
                    TextField("Restaurant Code", text: $viewModel.restCode)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()

                }
                
                
                MButton(title: "Create Account", background: .green, action: {viewModel.register()})
                
                
            }
            
            
        }
        
        VStack{
            if showInfo {
                Button(action: {
                    showInfo.toggle()
                }){
                    Text("Close")
                        .bold()
                }
                
                VStack(alignment: .center, spacing: 8) {
                    Text("NOT ADMINISTRATION:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("Register with a restaurant code (NOT as an administration) if you are a staff member syncing with an existing restaurant.")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                
                VStack(alignment: .center, spacing: 8) {
                    Text("ADMINISTRATION:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("Register as an administration if you are a manager facilitating the menu for your restaurant. A restaurant code will be assigned to you, which staff can sync with to view your menu. This account will be the only one that can make changes to your menu.")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                
                
            } else {
                Button(action: {
                    showInfo.toggle()
                }){
                    Text("How should I register?")
                        .bold()
                }
            }
        }
        
    }
}

#Preview {
    RegisterView()
}
