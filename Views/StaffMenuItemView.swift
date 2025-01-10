//
//  StaffMenuItemView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/22/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct StaffMenuItemView: View {
    @StateObject var viewModel = StaffMenuItemViewViewModel()
    
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
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(item.title):")
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}
