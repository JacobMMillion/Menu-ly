//
//  ContentView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            PostLoginLoadingScreen(userId: viewModel.currentUserId)
        } else {
            // This block should be executed when not signed in
            LoginView()
        }
    }
    
    
    
}



#Preview {
    MainView()
}

