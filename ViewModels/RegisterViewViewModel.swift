//
//  RegisterViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var isAdmin = false
    @Published var restCode = ""
    
    @Published var errorMessage = ""
    
    
    init() {}
    
    func register() {
        
        guard validate() else{
            errorMessage = "Please enter all fields"
            return
        }
        
        errorMessage = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userID = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userID)
            
        }
        
    }
    
    private func insertUserRecord(id: String){
        
        if(isAdmin){
            
            // generate restcode, same as admin userId
            restCode = id
            
//            let db = Firestore.firestore()
//            let menusAndItemsData: [String: Any] = [
//                "menus": [
//                    //"Dinner Entrees": ["item1", "item2", "item3"],
//                ]
//            ]
//            
//            db.collection("restaurants")
//                .document(restCode)
//                .setData(menusAndItemsData)
        }
        
        let newUser = User(id: id, name: name, email: email, isAdmin: isAdmin, restCode: restCode)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    private func validate() -> Bool{
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !restCode.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            return false
        }
        
        guard password.count >= 6 else{
            return false
        }
        
        return true
    }
    
    
}
