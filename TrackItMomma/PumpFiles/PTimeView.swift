//
//  PTimeView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI
import RealmSwift

struct PTimeView: View {
        @EnvironmentObject var realmManager: RealmManager
        var body: some View {
            VStack{
                Text("My times")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                List{
                    ForEach(realmManager.times, id: \.id) {
                        time in
                        if !time.isInvalidated{
                            PTimeRow(startTime: time.startTime, duration: time.duration, date: time.date, xDuration: time.xDuration ?? nil)
                            
                                .swipeActions(edge: .trailing){
                                    Button(role: .destructive) {
                                        realmManager.deleteTimes(id: time.id)
                                    } label: {
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
            }
        }
    }


struct PTimeView_Previews: PreviewProvider {
    static var previews: some View {
        PTimeView()
    }
}
