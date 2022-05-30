//
//  HourCondition.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
    
    var hour : String {
        get {
            Date(timeIntervalSince1970: TimeInterval(current.dt))
                .formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)))
        }
    }
    var day : String {
        get {
            Date(timeIntervalSince1970: TimeInterval(current.dt))
                .formatted(.dateTime.weekday(.abbreviated))
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(hour)
                Text(day)
            }
            Spacer()
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 75, height: 75)
                .shadow(color: .gray, radius: 2)
            Spacer()
            Text("\((Int)(current.temp))ºC")
            Text("\(current.weather[0].weatherDescription.rawValue.capitalized)")
        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
