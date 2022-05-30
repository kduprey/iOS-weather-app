//
//  Conditions.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import SwiftUI

struct Conditions: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            Image("weatherbg")
                .resizable()
                .opacity(0.75)
        
            VStack {
                Text(locationString)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        Task.init{
                            self.locationString = await getLocFromLatLong(lat: modelData.forecast.lat, lon: modelData.forecast.lon)
                            
                        }
                    }
                
                VStack{

        //          Temperature Info
                    VStack {
                        Text("\((Int)(modelData.forecast.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast.current.weather[0].icon)@2x.png")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 75, height: 75)
                            Text(modelData.forecast.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.white)
                        }
                        HStack{
                            Text("H: \((Int)(modelData.forecast.daily[0].temp.max))ºC")
                                .padding()
                            Text("Low: \((Int)(modelData.forecast.daily[0].temp.min))ºC")
                                .padding()
                        }
                        Text("Feels Like: \((Int)(modelData.forecast.current.feelsLike))ºC")
                            .foregroundColor(.white)
                    }.padding()
                    
        //            Wind Info
                    HStack {
                        Text("Wind Speed: \((Int)(modelData.forecast.current.windSpeed)) m/s")
                            .padding()
                        Text("Direction: \(convertDegToCardinal(deg:modelData.forecast.current.windDeg))")
                            .padding()
                    }.padding()
                        .font(.title3)

                    
        //           Humidity & Pressure
                    HStack {
                        Text("Humidity: \(modelData.forecast.current.humidity)%")
                            .padding()
                        Text("Presure: \(modelData.forecast.current.pressure) hPg")
                            .padding()
                    }
                    .font(.title3)

                    
        //            Sunset & Sunrise
                    HStack {
                        if ((modelData.forecast.current.sunset) != nil) {
                            HStack{
                                Image(systemName: "sunset.fill").renderingMode(.original)
                                Text("\(Date(timeIntervalSince1970: TimeInterval(modelData.forecast.current.sunset!)).formatted(date: .omitted ,time: .shortened))")
                            }
                        }
                        if ((modelData.forecast.current.sunrise) != nil) {
                            HStack {
                                Image(systemName: "sunrise.fill").renderingMode(.original)
                                Text("\(Date(timeIntervalSince1970: TimeInterval(modelData.forecast.current.sunrise!)).formatted(date: .omitted, time: .shortened))")
                            }
                        }
                    }
                    .font(.title3)

                }
                
            }
            .foregroundColor(.white)
            .shadow(color: .black,  radius: 4)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        Conditions()
            .environmentObject(ModelData())
    }
}
