//
//  LoginViewViewModel.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Published var resetEmail = ""
    
    @Published var resetMessage = ""
    
    
    init() {}
    
    func login() {
        // If validate returns true, attempt to log in with email and password
        guard validate() else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                // Sign-in failed
                DispatchQueue.main.async {
                    self?.errorMessage = "Invalid credentials"
                }
            }
        }
    }
    
    func validate() -> Bool{
        
        errorMessage = ""
        // if restuarant code is present, check it
        
        // otherwise attempt to login with email and password
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            errorMessage = "Please fill fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Please enter valid email"
            return false
        }
        
        return true
        
    }
    
    func reset(){
        
        if( resetEmail.trimmingCharacters(in: .whitespaces).isEmpty ){
            return
        }
            
        Auth.auth().sendPasswordReset(withEmail: resetEmail) { error in
            // error checking
        }
        
        self.resetMessage = "Sent!"
        
    }
    
}
