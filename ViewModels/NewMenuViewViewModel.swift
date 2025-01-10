//
//  NewMenuViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewMenuViewViewModel: ObservableObject{
    
    @Published var newMenuTitle = ""
    
    @Published var newMenuItemTitle = ""
    @Published var newMenuItemDescription = ""
    @Published var newMenuItemMenuDocument = ""
    
    
    
    
    @Published var showAlert = false
    @Published var user: User? = nil
    
    func saveMenu() {
        guard canSaveMenu else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newMenu = Menu(id: newId,
                           menuTitle: newMenuTitle,
                           items: [],
                           delete: false)
        
        
        let db = Firestore.firestore()
        
        // Fetch user data from Firestore
        
        db.collection("restaurant_descriptions")
            .document(uId)
            .collection("menus")
            .document(newId)
            .setData(newMenu.asDictionary())
        

        
    }
    
    func saveMenuItem() {
        guard canSaveMenuItem else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newMenuItem = MenuItem(id: newId, title: newMenuItemTitle, description: newMenuItemDescription)
        
    
        let db = Firestore.firestore()
        
        
        db.collection("restaurant_descriptions")
            .document(uId)
            .collection("menus")
            .document(newMenuItemMenuDocument)
            .collection("menu items")
            .document(newId)
            .setData(newMenuItem.asDictionary())
        

        
    }
    
    
    init() {}
    
    var canSaveMenu: Bool {
        guard !newMenuTitle.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        return true
    }
    
    var canSaveMenuItem: Bool {
        guard !newMenuItemTitle.trimmingCharacters(in: .whitespaces).isEmpty && !newMenuItemDescription.trimmingCharacters(in: .whitespaces).isEmpty && !newMenuItemMenuDocument.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        return true
    }
    
}
