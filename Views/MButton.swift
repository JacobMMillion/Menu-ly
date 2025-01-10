//
//  MButton.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/18/24.
//

import SwiftUI

struct MButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        
        Button{
            action()
            // Attempt login
            
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .padding()
    }
    
}

#Preview {
    MButton(title: "Title", background: .blue){
        //Action
    }
}
