//
//  LButton.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct LButton: View{
    @State private var aanimationNumb = 1.0
    
    var body: some View {
        Button("") {}
        .padding(65)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(aanimationNumb)
                .opacity(2 - aanimationNumb)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false)
                            .delay(1), value: aanimationNumb)
            )
        .transition(.scale)
        .onAppear {
            aanimationNumb += 1
        }
        .onDisappear {
            aanimationNumb = 1.0
        }
    }
}

struct LButton_Previews: PreviewProvider {
    static var previews: some View {
        LButton()
    }
}
