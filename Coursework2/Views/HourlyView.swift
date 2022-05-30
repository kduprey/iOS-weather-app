//
//  Hourly.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct HourlyView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack{
            Text("Hourly Forecast")
                .font(.title)
            List {
                ForEach(modelData.forecast.hourly) { hour in
                    HourCondition(current: hour)
                    
                }
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
