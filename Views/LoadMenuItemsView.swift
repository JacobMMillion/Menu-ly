//
//  LoadMenuItemsView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/22/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase


struct LoadMenuItemsView: View {
    
    @StateObject var viewModel = AdminMenuViewViewModel()
    
    let path: String
    let menu: Menu
    let userId: String
    let collectionPath: String
    
    @FirestoreQuery var menuItems: [MenuItem]
    
    init(userId: String, path: String, menu: Menu, collectionPath: String){
        self.userId = userId
        self.path = path
        self.menu = menu
        self._menuItems = FirestoreQuery(collectionPath: path)
        self.collectionPath = collectionPath
    }
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text("\(menu.menuTitle)")
                .font(.system(size: 18))
                .bold()


            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30) // Adjust the size as needed
            
            Spacer()
            
            Button {
                //Action
                viewModel.showingNewMenuView = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20)) // Adjust the size and weight
                    Text("Menu Item")
                    .bold()
            }
            
            
            Spacer()
        }
            
        
        List {
            ForEach(menuItems) { item in
                VStack() {
                    Text("\(item.title):")
                        .font(.headline)
                        .padding(.trailing, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .swipeActions {
                    Button("Delete") {
                        viewModel.deleteItem(userId: userId, menuId: menu.id, itemId: item.id)
                    }
                    .background(Color.red)
                    .foregroundColor(.white)
                }
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.showingNewMenuView, content: {
            NewMenuItemView(newMenuPresented: $viewModel.showingNewMenuView, menusPath: collectionPath, menuId: menu.id)
            })

    }
    
    
    
      
}

//#Preview {
//    LoadMenuItemsView(path: "", menu: "")
//}
