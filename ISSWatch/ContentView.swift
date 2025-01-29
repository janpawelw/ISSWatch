//
//  ContentView.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            //ISSMapView()
            Color.blue
                .edgesIgnoringSafeArea(.all)
            Button {
                appState.showMenu()
            } label: {
                Image(systemName: "line.3.horizontal")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                    .symbolVariant(.fill)
            }
            .padding(.trailing, 16)
            .padding(.top, 16)
            .sheet(isPresented: $appState.isShowingMenu) {
                ServicesListView()
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
