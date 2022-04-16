//
//  MenuView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct MenuView: View {
    @State private var showMenu         = true
    @State private var showPumpView     = false
    @State private var showLatchView    = false
    
    var body: some View {
        NavigationView{
            
            HStack(spacing: 0){
                
                ZStack{
                    //MARK: - Menu's

                    Color.primary.opacity(showMenu ? 0.9 : 0.0)
                    
                    VStack{
                        // Menu Content View
                        HStack{
                            Text("TRACK:")
                                .font(.caption.bold())
                                .foregroundColor(.orange)
                            //                        .padding(.top, 100)
                            Spacer()
                        }
                        Rectangle().fill(.gray).frame(height: 1)
                            .shadow(radius: 1)
                        
                        
                        Menu("LATCH"){
                            // default to screen, option to view tracked times, and start timer?
                            
                        } primaryAction: {
                            showLatchView.toggle()
                        }
                        .padding()
                        
                        
                        Menu("PUMP"){
                            Label("Start Tracking", systemImage: "timer")
                            Label("Check Log", systemImage: "list.bullet.rectangle.portrait.fill")
                        } primaryAction: {
                            showPumpView.toggle()
                        }
                        
                        .padding()
                        Menu("SLEEP"){}
                        .padding()
                    }
                    .font(.title2)
                    .foregroundColor(.orange)
                    
                    
                    
                }
                .frame(maxWidth: showMenu ? 100 : 0, maxHeight: .infinity)
                .opacity(showMenu ? 1.0 : 0.0)
                
                
                VStack{
                    //MARK: - ContentView

                    HStack{
                        Button(){
                            showMenu.toggle()
                        }label: {
                            Image(systemName: showMenu ? "record.circle": "record.circle.fill")
                        }
                        .padding(.top, 50 )
                        
                        Spacer()
                    }
                    
                    ZStack{
                        Color.orange
                        
                        
                        VStack{
                            
                            Text("Track it Momma!")
                                .opacity(showMenu ? 0.5 : 1.0)
                        }
                    }
                    //MARK: - Navigation Links

                    NavigationLink(destination: PumpView(), isActive: $showPumpView){
                        EmptyView()
                    }
                    NavigationLink(destination: LatchView(), isActive: $showLatchView){
                        EmptyView()
                    }
                }
                .font(.largeTitle)
            }
            .background(Rectangle().fill(Color.orange))
            .ignoresSafeArea()
            .foregroundColor(.white)
            .animation(.easeInOut, value: showMenu)
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
