//
//  SearchView.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/29/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var searchQuery: String = ""
    @State private var locationResults: [MKMapItem] = []
    
    @Binding var userLocation: MKMapItem
    @Binding var isSearchOpen : Bool
    
    var body: some View {
        NavigationView {
                List{
                    if (!locationResults.isEmpty){
                        ForEach(locationResults, id: \.self) { location in
                            Button {
                                userLocation = location
                                modelData.loadData(lat: userLocation.placemark.coordinate.latitude, lon: userLocation.placemark.coordinate.longitude)
                                
                                isSearchOpen.toggle()
                                print(userLocation.placemark.location?.coordinate.latitude as Any)
                            } label: {
                                VStack {
                                    Text(location.placemark.name ?? location.description)
                                        .font(.body)
                                    if (location.placemark.country != nil) {
                                        Text(location.placemark.country!)
                                        .font(.subheadline)
                                    }
                                }
                            }

                                
                        }
                    }
                        
                }.navigationTitle("Location Search")
                    
            }
                .searchable(text: $searchQuery)
                .onChange(of: searchQuery) { search in
                let searchQueryInit = MKLocalSearch.Request()
                searchQueryInit.naturalLanguageQuery = search
                
                let searchRequest = MKLocalSearch(request: searchQueryInit)
                
                searchRequest.start() { response, error in
                    guard let response = response else {
                        print("Error: " + (error?.localizedDescription ?? "unknown error"))
                        return
                    }
                    locationResults = response.mapItems
                }
            
            }
       
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(userLocation: Binding<MKMapItem>.constant(MKMapItem(placemark: MKPlacemark(coordinate: (CLLocationCoordinate2D(latitude: 51.517063981037964, longitude: -0.1431738452133919))))), isSearchOpen: Binding<Bool>.constant(false))
    }
}
