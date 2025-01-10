//
//  UpdateCodeView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/22/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct UpdateCodeView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    @State private var newCode = ""
    
    let user: User
    
    init(user: User) {
        
        self.user = user
        
    }
    
    var body: some View {

        
        Text("Update Restaurant Code")
            .padding()
            .font(.system(size: 18))
            .bold()
        
        Text("Only staff accounts can change their affiliated code")
            .font(.footnote)
        
        Form{
            
            if !viewModel.restCodeErrorMessage.isEmpty{
                Text(viewModel.restCodeErrorMessage)
                    .foregroundColor(Color.red)
                    .font(.footnote)
                    .bold()
            }
            
            TextField("New Code: ", text: $newCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
            
            MButton(title: "Update Code", background: .blue, action: {viewModel.updateCode(newCode: newCode, user: user)})
            
            Text("You will be logged out upon code change")
                .font(.footnote)
            
        }
    }
    
    

    
}

//#Preview {
//    UpdateCodeView()
//}
