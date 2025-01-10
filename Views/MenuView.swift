//
//  MenuView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct MenuView: View {
    @StateObject var viewModel = MenuViewViewModel()
    
    @FirestoreQuery var menuItems: [MenuItem]
    
    let menu: Menu
    let path: String
    
    init(menu: Menu, path: String){
        self.menu = menu
        self.path = path
        
        self._menuItems = FirestoreQuery(collectionPath: path)

    }

    
    var body: some View {
        HStack {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    Text(menu.menuTitle)
                        .bold()
                        .font(.largeTitle)
                        .underline()
                    
                    }
                }
                .padding()
            }
        }
        
    }

#Preview {
    MenuView(menu: Menu(id: "111", menuTitle: "Dinner Menu", items: [], delete: false), path: "")
}
