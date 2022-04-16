//
//  LTimeRow.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct LTimeRow: View {
    var finishedTime: String
    var totalDuration: String
    var currentDate: String?
    
    
    var body: some View {
        if let currentDate = currentDate {
        VStack{
            Text(currentDate)
                .fontWeight(.heavy)
        }
        .listRowSeparator(.hidden)
        .font(.headline)
        }
        HStack(spacing: 30) {
            Text(" Finished at \(finishedTime)")
            Text("\(totalDuration) minutes total")
        }
        .listRowSeparator(.visible)
        .preferredColorScheme(.light)
    }
}

