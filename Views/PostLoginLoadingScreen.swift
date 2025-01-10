//
//  PostLoginLoadingScreen.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/22/24.
//

import SwiftUI

struct PostLoginLoadingScreen: View {
    
    @StateObject var viewModel = PostLoginLoadingScreenViewModel()
    
    @State private var isAdmin: Bool? = nil
    private var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let isAdmin = isAdmin {
                    if isAdmin{
                        adminAccountView
                    }else if !isAdmin{
                        staffAccountView
                    }
                } else {
                    Text("Loading...")
                        .bold()
                }
            }
            .onAppear() {
                viewModel.fetchUser()
            }
            .onChange(of: viewModel.user?.isAdmin) {
                if viewModel.user?.isAdmin == nil{
                    
                }
                else{
                    isAdmin = viewModel.user?.isAdmin
                }
            }
        }
    }
    
    
    
    @ViewBuilder
    var adminAccountView: some View {
        TabView{
            AdminMenuView(userId: userId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .navigationViewStyle(.stack)

    
    }
    
    
    
    @ViewBuilder
    var staffAccountView: some View {
        TabView{
            TabView{
                StaffMenuView(userId: userId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }

        }
        
        

    }
    
    
    
    
}

#Preview {
    PostLoginLoadingScreen(userId: "")
}
