//
//  NewMenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct NewMenuItemView: View {
    
    @StateObject var viewModel = NewMenuViewViewModel()
    @Binding var newMenuPresented: Bool
    let menusPath: String
    
    @FirestoreQuery var menus: [Menu]
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedMenuId: String = ""
    @State private var menuId: String
    
    init(newMenuPresented: Binding<Bool>, menusPath: String, menuId: String) {
        self._newMenuPresented = newMenuPresented
        self.menusPath = menusPath
        self._viewModel = StateObject(wrappedValue: NewMenuViewViewModel())
        
        self._menus = FirestoreQuery(collectionPath: menusPath)
        self.menuId = menuId
        
    }
    
    
    var body: some View {
        VStack{
            
            Text("Add Menu Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 40)
            
            Form{
                
                TextField("Title", text: $viewModel.newMenuItemTitle)
                    .disableAutocorrection(true) // Disable spell checking
                TextField("Description:", text: $viewModel.newMenuItemDescription, axis: .vertical)
                    .disableAutocorrection(true) // Disable spell checking
                    .lineLimit(6)

                // menusPath has all the menus. the document of each menu is its id, and it has a field with the menuTitle
                // I want the user to be able to select the menu by its title, and then assign its respective id to
                // docId
//                Picker("Select Menu", selection: $selectedMenuId) {
//                                    ForEach(menus, id: \.id) { menu in
//                                        Text(menu.menuTitle).tag(menu.id)
//                                    }
//                                }
//                
//                Text(selectedMenuId)
                
                
                //setNewMenuItemMenuDocument( docId )
                
                MButton(title: "Add", background: .pink){
                    
                    viewModel.newMenuItemMenuDocument = menuId
                    
                    if( viewModel.canSaveMenuItem ){
                        viewModel.saveMenuItem()
                        newMenuPresented = false
                        presentationMode.wrappedValue.dismiss()
                    } else{
                        viewModel.showAlert = true
                    }
    
                    
                }
                .padding()
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
