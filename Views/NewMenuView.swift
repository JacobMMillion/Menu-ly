//
//  NewMenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct NewMenuView: View {
    
    @StateObject var viewModel = NewMenuViewViewModel()
    @Binding var newMenuPresented: Bool
    let menusPath: String
    
    @FirestoreQuery var menus: [Menu]
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedMenuId: String = ""
    
    init(newMenuPresented: Binding<Bool>, menusPath: String) {
        self._newMenuPresented = newMenuPresented
        self.menusPath = menusPath
        self._viewModel = StateObject(wrappedValue: NewMenuViewViewModel())
        
        self._menus = FirestoreQuery(collectionPath: menusPath)
        
    }
    
    
    var body: some View {
        VStack{
            
            Text("Add A Menu")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 40)
            
            Form{
                TextField("Title", text: $viewModel.newMenuTitle)
                
                MButton(title: "Add", background: .pink){
                    
                    if( viewModel.canSaveMenu ){
                        viewModel.saveMenu()
                        newMenuPresented = false
                        presentationMode.wrappedValue.dismiss() // remove?
                    } else{
                        viewModel.showAlert = true
                    }
                    

                }
        
                .padding()
                
                Spacer()

            }
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: Text("Error"), message: Text("Please fill in appropriate fields"))
            }
            
            
            
        }

        
    }
}

//#Preview {
//    NewMenuView(newMenuPresented: Binding(get: {
//        return true
//    }, set: { _ in
//    
//    }))
//}
