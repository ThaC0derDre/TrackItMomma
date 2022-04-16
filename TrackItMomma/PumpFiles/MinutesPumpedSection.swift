//
//  MinutesPumpedSection.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct MinutesPumpSection: View {
    @State var pumpTime: Int
    var body: some View {
        VStack{
            Text("How many minutes?")
                .font(.headline)
            
            Stepper("\(pumpTime) minutes", value: $pumpTime, in: 5...30, step: 1, onEditingChanged: { _ in
                
            })
                .padding()
        }
    }
}
