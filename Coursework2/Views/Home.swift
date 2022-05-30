//
//  StartView.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/26/22.
//

import SwiftUI
import MapKit


struct Home: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var isSearchOpen: Bool = false
    @State var locationName: String = "No Location"
    @State var userLocation: MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: (CLLocationCoordinate2D(latitude: 51.517063981037964, longitude: -0.1431738452133919))))
    
    
    
    let backgroundImage = Image("weatherbg")
    
    var body: some View {
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 45, height: 45)
                    }.sheet(isPresented: $isSearchOpen) {
                        SearchView(userLocation: $userLocation, isSearchOpen: $isSearchOpen)
                    }
                    .padding()
                        Spacer()

                }
                
                
                
                Text(locationName)
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4)
                    .multilineTextAlignment(.center)
                Text("\((Int)(modelData.forecast.current.temp))ºC")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4)
                Text("Humidity: \((Int)(modelData.forecast.current.humidity))%")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4)
                Spacer()
            }
            .onAppear(perform: {
                Task.init{
                    self.locationName = await getLocFromLatLong(lat: modelData.forecast.lat, lon: modelData.forecast.lon)
                }
            })
            .onChange(of: userLocation, perform: { newValue in
                Task.init{
                    self.locationName = await getLocFromLatLong(lat: userLocation.placemark.coordinate.latitude, lon: userLocation.placemark.coordinate.longitude)
                }
            })
            .background {
                Image("weatherbg")
                    .resizable()
                    .opacity(0.75)
            }.ignoresSafeArea(edges: .top)
      
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
            Home()
                .environmentObject(ModelData())
            
    }
}
