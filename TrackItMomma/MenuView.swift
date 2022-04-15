//
//  MenuView.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import SwiftUI

struct MenuView: View {
    @State private var showMenu = true
    
    var body: some View {
        HStack(spacing: 0){
            
            ZStack{
                // Menu
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
                        // default to screen, option to view tracked times.
                    }
                    .padding()
                    Menu("PUMP"){}
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
                //Content View
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
            }
            .font(.largeTitle)
        }
        .background(Rectangle().fill(Color.orange))
        .ignoresSafeArea()
        .foregroundColor(.white)
        .animation(.easeInOut, value: showMenu)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .preferredColorScheme(.dark)
    }
}
