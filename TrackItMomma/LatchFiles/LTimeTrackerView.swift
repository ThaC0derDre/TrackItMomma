//
//  LTimeTrackerView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct TrackTimeView: View {
    @EnvironmentObject var  realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    @State private var lastFedAt    = ""
    @State private var durationFed  = ""
    @State private var currentDate  = ""
    @State private var nextDay      = ""
    @State private var newDay       = false
    
    
    var body: some View {
        VStack {
            Text("Time Tracker")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(realmManager.times, id: \.id) {
                    time in
                    if !time.isInvalidated {
                        LTimeRow(finishedTime: time.lastFed, totalDuration: time.duration, currentDate: time.currentDate)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    realmManager.deleteTime(id: time.id)
                                }label: {
                                     Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
            Button {
                dismiss()
            } label: {
                Text("Back to Tracker")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                    .cornerRadius(30)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}
