//
//  StaffMenuViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/21/24.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class StaffMenuViewViewModel: ObservableObject {
    
    init() {
        
    }
    
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

    
    
    
}
