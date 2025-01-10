//
//  StaffMenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/20/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct StaffMenuView: View {
    
    @StateObject var viewModel = StaffMenuViewViewModel()
    @State private var restCode: String? = nil
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if let restCode = restCode {
                    LoadMenuView(restCode: restCode)
                } else {
                    Text("Loading Menus...")
                        .bold()
                }
            }
            .onAppear() {
                viewModel.fetchUser()
            }
            .onChange(of: viewModel.user?.restCode) {
                if viewModel.user?.restCode == nil{
                    
                }
                else{
                    restCode = viewModel.user?.restCode
                }
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    StaffMenuView(userId: "")
}
