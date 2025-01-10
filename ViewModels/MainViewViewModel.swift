//
//  MainViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var user: User? = nil
    
    private var handler: AuthStateDidChangeListenerHandle?
    private var firestoreListener: ListenerRegistration?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
        
        fetchUser()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  email: data["email"] as? String ?? "",
                                  isAdmin: data["isAdmin"] as? Bool ?? false,
                                  restCode: data["restCode"] as? String ?? "")
                
            }
            
            
        }
        
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
