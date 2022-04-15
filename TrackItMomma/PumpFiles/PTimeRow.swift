//
//  PTimeRow.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct PTimeRow: View {
    @State var startTime: String
    @State var duration: Int
    @State var date: String
    @State var xDuration:Int?
    
    var body: some View {
        VStack{
            Text(date)
                .font(.title2.bold())
                
                
            HStack{
                Spacer()
                Text("Started at \(startTime)")
                Spacer()
                Spacer()
                if xDuration != nil {
                    VStack(){
                    Text("First side: \(duration) Mins")
                        Text("Other side: \(xDuration!) Mins")
                    }
                } else {
                    Text("\(duration) Mins each ")
                    Spacer()
                }
            }
        }
    }
}

