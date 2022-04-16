//
//  LatchView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI
import RealmSwift


struct LatchView: View {
    
    @StateObject var realmManager = RealmManager()
    
    
    @State private var startTime        = ""
    @State private var endTime          = ""
    @State private var timeDifference   = ""
    @State private var minsPassed       = ""
    
    
    @State private var showTimeView     = false
    @State private var timeCounting     = false
    @State private var timerStopped     = false
    @State private var tFormatter       = LTimeFormatter()
    @State private var theDate:String?
    @State private var timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    if !timeCounting {
                        Button("Start Timer"){
                            timerStopped    = false
                            startTime = tFormatter.getCurrentTime()
                            guard !timeCounting else { return }
                            timeCounting.toggle()
                            self.timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
                        }
                    }
                    
                    if timeCounting {
                        Text("Latched at \(startTime)")
                    }
                    
                    if timeCounting {
                        Text(minsPassed == "0" ? "Counting Minutes..." : "Minutes passed: \(minsPassed)")
                    }
                    if timerStopped {
                        Text(timeDifference == "0" ? "Zero minutes passed that time." : "Total: \(timeDifference) minutes")
                    }
                    
                    
                    Section {
                        Button("View Previous Times") {
                        }
                        
                        .onTapGesture {
                            showTimeView.toggle()
                        }
                    }
                    .sheet(isPresented: $showTimeView) {
                        TrackTimeView()
                            .environmentObject(realmManager)
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
                
                //MARK: - Button
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    ZStack(alignment:.bottom) {
                        
                        
                        if timeCounting{
                            LButton()
                            Button("END") {
                                timeCounting    = false
                                timerStopped    = true
                                endTime         = tFormatter.getCurrentTime()
                                theDate         = tFormatter.getCurrentDate()
                                timeDifference  = tFormatter.findDateDiff(time1Str: startTime, time2Str: endTime)
                                
                                if timeDifference != "" {
                                    realmManager.addTime(lastFed: endTime, duration: timeDifference, currentDate: theDate)
                                }
                            }
                            .font(.title2.bold())
                            .padding(60)
                            .foregroundColor(.white)
                            .onReceive(timer) { _ in
                                if !timeCounting {
                                    self.timer.upstream.connect().cancel()
                                    return
                                }else {
                                    endTime = tFormatter.getCurrentTime()
                                    minsPassed = tFormatter.findDateDiff(time1Str: startTime, time2Str: endTime)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                .navigationTitle("LATCHED")
                .navigationBarTitleDisplayMode(.inline)
                .animation(.default, value: timeCounting)
            
            .preferredColorScheme(.light)
        }
    }
}


struct LatchView_Previews: PreviewProvider {
    static var previews: some View {
        LatchView()
    }
}
