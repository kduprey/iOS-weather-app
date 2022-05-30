//
//  DailyView.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 75, height: 75)
                .shadow(color: .gray, radius: 2)
            Spacer()
            VStack {
                Text(day.weather[0].weatherDescription.rawValue.capitalized)
                Text(Date(timeIntervalSince1970: TimeInterval(day.dt)).formatted(.dateTime.weekday(.wide).day(.twoDigits)))
            }
            Spacer()
            Text("\((Int)(day.temp.max))ºC / \((Int)(day.temp.min))ºC" )
        }.padding()
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
