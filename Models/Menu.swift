//
//  Menu.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/20/24.
//

import Foundation

struct Menu: Codable, Identifiable{
    
    let id: String
    let menuTitle: String
    let items: [MenuItem]
    
    var delete: Bool
    
    mutating func delete( _ state: Bool){
        delete = state
    }
    
}
