//
//  FlashcardView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 3/1/24.
//

import SwiftUI

struct FlashcardView: View {
    
    @State private var currentIndex = 0
    @State private var finished = false
    
    private var shuffledMenuItems: [MenuItem]
    
    init(menuItems: [MenuItem]){
        self.shuffledMenuItems = menuItems.shuffled()
    }
    
    @State private var showBack = false
    
    var body: some View {
        VStack {
            if finished{
                FinishedScreen
            }
            else if showBack {
                // Display back of the flashcard
                
                // Bold only "Description:" and the description word
                Text("Description: ")
                    .bold()
                    .multilineTextAlignment(.center)
                Text(shuffledMenuItems[currentIndex].description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                
            } else {
                // Display front of the flashcard
                Text(shuffledMenuItems[currentIndex].title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
            }
            
        }
        .onTapGesture {
            // Flip the flashcard
            withAnimation {
                showBack.toggle()
            }
        }
        .padding(50)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        
        
        VStack {
            HStack {
                Button(action: {
                    // Move to the next flashcard or disable the button if at the end
                    if currentIndex < shuffledMenuItems.count - 1 {
                        currentIndex += 1
                        // Always show the front when moving to the next card
                        showBack = false
                    }
                    else{
                        finished = true
                    }
                    
                }) {
                    Text(finished ? "All Cards Shown" : "Next Card")
                        .foregroundColor(.white)
                        .padding()
                        .background(finished ? Color.gray : Color.blue)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
                .padding()
                
            }
        }
    }
}

@ViewBuilder
var FinishedScreen: some View{
    VStack{
        Text("You have reached the end of the stack!")
            .bold()
            .multilineTextAlignment(.center)
            .foregroundColor(Color.black)
    }
}
    
//    var body: some View {
//        VStack {
//            HStack {
//                if isShowingFront {
//                    Text(shuffledMenuItems[currentIndex].title)
//                        .font(.title)
//                        .padding()
//                        .foregroundColor(.black)
//                } else {
//                    Text(shuffledMenuItems[currentIndex].description)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding()
//                }
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .background(Color.white)
//            .cornerRadius(10)
//            .shadow(radius: 5)
//            .padding()
//            
//            Spacer()
//            
//            HStack {
//                Button(action: {
//                    // Toggle between front and back of the flashcard
//                    isShowingFront.toggle()
//                }) {
//                    Text("Flip")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding()
//                
//                Button(action: {
//                    // Move to the next flashcard or disable the button if at the end
//                    if currentIndex < shuffledMenuItems.count - 1 {
//                        currentIndex += 1
//                        // Always show the front when moving to the next card
//                        isShowingFront = true
//                    }
//                    
//                }) {
//                    Text("Next Card")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.green) // Change the color or style as needed
//                        .cornerRadius(8)
//                }
//                .padding()
//                .disabled(currentIndex == shuffledMenuItems.count - 1)
//            }
//        }
//        .padding()
//        .navigationTitle("Flashcard")
//    }
//}
//#Preview {
//    FlashcardView()
//}
