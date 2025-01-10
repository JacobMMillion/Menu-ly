//
//  AdminMenuViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AdminMenuViewViewModel: ObservableObject {
    
    @Published var showingNewMenuView = false
    
    init() {
        
    }
    
    func deleteMenu(userId: String, menuId: String){
        
        let db = Firestore.firestore()
        
        db.collection("restaurant_descriptions")
            .document(userId)
            .collection("menus")
            .document(menuId)
            .delete()
        
        
    }
    
    func deleteItem(userId: String, menuId: String, itemId: String){
        
        let db = Firestore.firestore()
        
        db.collection("restaurant_descriptions")
            .document(userId)
            .collection("menus")
            .document(menuId)
            .collection("menu items")
            .document(itemId)
            .delete()
        
    }
    
    
    
    
}

