//
//  ProfileView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    @State private var showAlert = false
    @State private var showInfo = false
    
    var body: some View {
        NavigationStack{
            VStack{
        
                
                if let user = viewModel.user{
                    profile(user: user)
                }
                else{
                    Text("Loading Profile...")
                        .bold()
                }
                
                
            }
            .navigationTitle("Profile")
            .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Warning"),
                                message: Text("Are you sure you want to delete your account? This action is irreversible."),
                                primaryButton: .default(Text("Cancel")),
                                secondaryButton: .destructive(Text("Delete"), action: {
                                    viewModel.deleteAccount()
                                })
                            )
            }
            
        }
        .onAppear(){
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View{
        
        Spacer()
        
        HStack {
            
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: 30, height: 30) // Adjust the size as needed
                .padding()
            
            Text("Profile")
                .font(.system(size: 18))
                .bold()
            
        }
        
        // avatar
        Spacer()
        
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 123, height: 125) // Adjust the size as needed
        
        // info
        VStack(alignment: .leading){
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack{
                Text("Email: ")
                     .bold()
                Text(user.email)
            }
            .padding()
            HStack{
                Text("Resturant Code: ")
                    .bold()
                Text(user.restCode)
            }
            .padding()
            HStack{
                Text("Admin Permissions: ")
                    .bold()
                Text(String(describing: user.isAdmin))
            }
            .padding()
            
            
        }
        .padding()
        
        VStack{
            NavigationLink("Update Restaurant Code", destination: UpdateCodeView(user: user))
        }
        .tint(.blue)
        
        VStack{
            NavigationLink("Change Password", destination: ChangePasswordView(user: user))
        }
        .tint(.blue)
        
        Spacer()
        
        // sign out
        Button("Log Out"){
            viewModel.logOut()
        }
        .tint(.red)
        .bold()
        
        Button("Delete Account"){
            showAlert = true
        }
        .tint(.red)
        
        Spacer()
    }
}

#Preview {
    ProfileView()
}
