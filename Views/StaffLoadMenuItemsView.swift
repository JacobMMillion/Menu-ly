//
//  StaffLoadMenuItemsView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/23/24.
//
import SwiftUI
import FirebaseFirestore
import Firebase


struct StaffLoadMenuItemsView: View {
    
    let path: String
    let menu: Menu
    let userId: String
    
    @State private var isFlashcardViewActive = false
    
    @FirestoreQuery var menuItems: [MenuItem]
    
    init(userId: String, path: String, menu: Menu){
        self.userId = userId
        self.path = path
        self.menu = menu
        self._menuItems = FirestoreQuery(collectionPath: path)
    }
    
    var body: some View {
        
        HStack {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30) // Adjust the size as needed
            
            Text("\(menu.menuTitle)")
                .font(.system(size: 18))
                .bold()
            
        }

        
        List {
            ForEach(menuItems) { item in
                VStack() {
                    Text("\(item.title):")
                        .font(.headline)
                        .padding(.trailing, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

            }
        }
        .padding()
        
        HStack{
            NavigationLink(destination: FlashcardView(menuItems: menuItems)) {
                Text("Generate Flashcards")
                    .bold()
                    .padding(8)
            }
        }

    }
    
      
}


