//
//  PumpView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI
//import RealmSwift


struct PumpView: View {
    @StateObject var realmManager   = PRealmManager()
    @State private var startTime    = ""
    @State private var pumpAmount   = 10
    @State private var xPumpAmount  = 12
    @State private var trackButton  = "Track"
    @State private var clickLabel   = "Click to track time"
    @State private var sameTime     = true
    @State private var showTimeV    = false
    
    private var saveText: String {
        saved ? "Saved" : "Save"
    }
    @State private var saved    = false
    
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(clickLabel)
                        .padding(.leading)
                    Spacer()
                    
                    Button("\(trackButton)") {
                        getTimeFor("left")
                    }
                    .padding(.trailing)
                }
                VStack{
                    Text("How many minutes?")
                        .font(.headline)
                    
                    Stepper("\(pumpAmount) minutes", value: $pumpAmount, in: 5...30, step: 1, onEditingChanged: { _ in
                    })
                    HStack{
                        Section{
                            Toggle("Match Duration?", isOn: $sameTime)
                        }
                    }
                    .padding()
                }
            }header: {
                if !sameTime {
                    Text("LEFT SIDE")
                }else{
                    Text("")
                }
            }
            
            if !sameTime {
                Section{
                    VStack{
                        Text("How many minutes?")
                            .font(.headline)
                        
                        Stepper("\(xPumpAmount) minutes", value: $xPumpAmount, in: 5...30, step: 1, onEditingChanged: { _ in
                        })
                            .padding()
                    }
                }header: {
                    Text("RIGHT SIDE")
                }
            }
                
            
            //MARK: - SHOW PREVIOUS TIMES
            
            Button("Show Previous Times"){
                showTimeV = true
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
        .animation(.default, value: sameTime)
        .navigationTitle("Pump")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
        .sheet(isPresented: $showTimeV) {
            PTimeView()
                .environmentObject(realmManager)
        }
        
        ZStack{
            HStack{
                Text(saveText)
                    .font(.title2)
                Image(systemName: saved ? "checkmark.circle" : "circle")
            }
            .foregroundColor(.white)
            .padding(25)
            .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
            .cornerRadius(450)
            .onTapGesture {
                if startTime != "" {
                    realmManager.addTime(startTime: startTime, duration: pumpAmount, date: getCurrentDate(), xDuration: sameTime ? nil : xPumpAmount)
                    
                    saved = true
                    withAnimation {
                        resetScreen()
                    }
                }
            }
            .padding(.bottom)
        }
    }
        
        
        func getTimeFor(_ side: String) {
            let currentTime = Date.now
            if side == "left" {
                startTime = currentTime.formatted(date: .omitted, time: .shortened)
                trackButton = startTime
                clickLabel = "Started at"
            }
        }
        
        private func resetScreen() {
            // Delay of 2.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    startTime       = ""
                    pumpAmount      = 10
                    trackButton     = "Track"
                    clickLabel      = "Click to track time"
                    sameTime        = true
                    saved           = false
                }
            }
        }
        
        
    }
    
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat    = "MMM d, EEEE"
        
        let dateString = formatter.string(from: Date())
        print(dateString)
        return dateString
    }

struct PumpView_Previews: PreviewProvider {
    static var previews: some View {
        PumpView()
    }
}
