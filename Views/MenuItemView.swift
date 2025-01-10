//
//  MenuItemView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct MenuItemView: View {
    @StateObject var viewModel = MenuItemViewViewModel()
    
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
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(menuItems) { item in
                        HStack() {
                            Text("\(item.title):")
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .swipeActions {
                            Button("Delete") {
                                viewModel.deleteItem(id: item.id)
                            }
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

