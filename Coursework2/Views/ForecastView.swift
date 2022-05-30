//
//  Forecast.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack{
            Text("Forecast").font(.title)
            List{
                ForEach(modelData.forecast.daily) { day in
                    DailyView(day: day)
                }
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
