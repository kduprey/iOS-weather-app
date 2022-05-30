//
//  NavBar.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Conditions()
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Conditions")
                }
            HourlyView()
                .tabItem{
                    Image(systemName: "clock")
                    Text("Hourly")
                }
            ForecastView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Forecast")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

struct NavBar_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        NavBar()
            .environmentObject(ModelData())
    }
}
