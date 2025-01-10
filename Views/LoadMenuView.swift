//
//  LoadMenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/21/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct LoadMenuView: View {
    
    @StateObject var viewModel = LoadMenuViewViewModel()
    @FirestoreQuery var menus: [Menu]
    
    private let restCode: String
    let collectionPath: String

    let db = Firestore.firestore()
    
    init(restCode: String){
        self.restCode = restCode
        collectionPath = "restaurant_descriptions/\(restCode)/menus"
        self._menus = FirestoreQuery(collectionPath: "restaurant_descriptions/\(restCode)/menus")
    }
    
    var body: some View {
        NavigationStack{
                
                
            VStack {
                Spacer()
                
                HStack {
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30) // Adjust the size as needed
                    
                    Text("Menus")
                        .padding()
                        .font(.system(size: 18))
                        .bold()
                    
                }
                
                // iterating through each menu
                List(menus) { menu in
                    
                    // display the menu
                    // let each menu be clickable. if clicked, opens up new page with menu items
                    // would need to pass the path to this.
                    VStack{
                        
                        NavigationLink("\(menu.menuTitle)", destination: StaffLoadMenuItemsView(userId: restCode, path: "restaurant_descriptions/\(restCode)/menus/\(menu.id)/menu items", menu: menu))
                        
                    }
                    .padding()
                    
                    
                    
                }
                .listStyle(PlainListStyle())
                
                
                
                
            }
            .navigationBarHidden(true)
            
        }
            
        }
        
        
    
}
#Preview {
    LoadMenuView(restCode: "")
}
