//
//  ProfileViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class ProfileViewViewModel: ObservableObject {
    
    @Published var restCodeErrorMessage = ""
    @Published var passwordErrorMessage = ""
    
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser(){
        
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument{ [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                return
            }
            
            
            DispatchQueue.main.async{
                self?.user = User(id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  email: data["email"] as? String ?? "",
                                  isAdmin: data["isAdmin"] as? Bool ?? false,
                                  restCode: data["restCode"] as? String ?? "")
            }
        }
    }
    
    func logOut(){
        
        do{
            try Auth.auth().signOut()
        }
        catch{
            print(error)
        }
        
    }
    
    func updateCode(newCode: String, user: User) {
        
        // if is admin, we dont allow
        if( user.isAdmin ){
            DispatchQueue.main.async {
                self.restCodeErrorMessage = "Administrators cannot change their code."
            }
            return
        }
        
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(user.id)
        
        docRef.updateData(["restCode": newCode]) { error in
            if let error = error {
                
            } else {
                print("Document successfully updated!")
                do{
                    try Auth.auth().signOut()
                }
                catch{
                    print(error)
                }
            }
            
        }
    }
        
        
        func changePassword(password: String, user: User){
            
            Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                if let error = error {
                    
                    DispatchQueue.main.async {
                        self.passwordErrorMessage = "Unsuccessful. Ensure password is at least 6 characters. If so: log in, log out, and try again."
                    }
                    
                } else {
                    print("Password successfully updated!")
                    do{
                        try Auth.auth().signOut()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            
        }
        
        func deleteAccount(){
            
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            
            // delete from database
            if let uid = user?.uid {
                db.collection("users")
                    .document(uid)
                    .delete { error in
                        if let error = error {
                            print("Error deleting document: \(error.localizedDescription)")
                        } else {
                            print("Document deleted successfully.")
                        }
                    }
            } else {
                print("User UID is nil.")
            }
            
            
            // delete log in from auth
            user?.delete { error in
                if let error = error {
                    // An error happened.
                    print("error in account deleting")
                } else {
                    // Account deleted.
                    do{
                        try Auth.auth().signOut()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            
        }
        
}
