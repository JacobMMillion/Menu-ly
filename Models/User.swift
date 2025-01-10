//
//  User.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import Foundation

struct User: Codable, Equatable{
    let id: String
    let name: String
    let email: String
    
    let isAdmin: Bool
    let restCode: String
    
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id &&
                   lhs.name == rhs.name &&
                   lhs.email == rhs.email &&
                   lhs.isAdmin == rhs.isAdmin &&
                   lhs.restCode == rhs.restCode
        }
}
