//
//  AdminMenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct AdminMenuView: View {
    @StateObject var viewModel = AdminMenuViewViewModel()
    
    @FirestoreQuery var menus: [Menu]
    
    private let userId: String
    let collectionPath: String

    let db = Firestore.firestore()
    
    init(userId: String){
        self.userId = userId
        collectionPath = "restaurant_descriptions/\(userId)/menus"
        self._menus = FirestoreQuery(collectionPath: "restaurant_descriptions/\(userId)/menus")
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Spacer()
                
                
                HStack {
                    
                    Spacer()
                    
                    Text("Menus")
                        .padding()
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
                            Text("Menu")
                            .bold()
                    }
                    
                    
                    Spacer()
                    
                }
                Spacer()
                
                // iterating through each menu
                List(menus) { menu in
                    
                    // display the menu
                    // let each menu be clickable. if clicked, opens up new page with menu items
                    // would need to pass the path to this.
                    VStack{
                        
                        NavigationLink("\(menu.menuTitle)", destination: LoadMenuItemsView(userId: userId, path: "restaurant_descriptions/\(userId)/menus/\(menu.id)/menu items", menu: menu, collectionPath: collectionPath))
                        
                    }
                    .padding()
                    .swipeActions{
                        Button("Delete"){
                            viewModel.deleteMenu(userId: userId, menuId: menu.id)
                        }
                        .background(Color.red)
                        .foregroundColor(Color.red)
                    }
                            
                            
                        
                }
                .listStyle(PlainListStyle())
                    
                    
                    
                    
                }
                //.navigationTitle("Menus")
                .navigationBarHidden(true)
                .sheet(isPresented: $viewModel.showingNewMenuView, content: {
                    NewMenuView(newMenuPresented: $viewModel.showingNewMenuView, menusPath: collectionPath)
                    })

            }
            
            
        }
        
        
    
}





#Preview {
    AdminMenuView(userId: "")
}
