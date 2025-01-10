//
//  HeaderView.swift
//  Menuly2.0
//
//  Created by Jacob Million on 2/17/24.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            
            VStack{
                Image("Menuly-logos")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175)
                
                Text(subtitle)
                    .font(.system(size:18))
                    .foregroundColor(Color.black)
                    .bold()
                    .italic()
            }
            
            .padding(.top,angle)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 250)
    }
}

#Preview {
    HeaderView(title: "Title",
               subtitle: "Subtitle",
               angle: 0,
               background: .pink
                )
}
