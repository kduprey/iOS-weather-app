//
//  LocationHelper.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/28/22.
//

import Foundation
import MapKit

func getLocFromLatLong(lat: Double, lon: Double) async -> String
{
    var locationString: String
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let ceo: CLGeocoder = CLGeocoder()
    
    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    do {
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        if placemarks.count > 0 {
            print((placemarks[0].locality ?? "No City") + ", " + (placemarks[0].country ?? "No Country"))
            
            if (!placemarks[0].name!.isEmpty) {
                print(placemarks[0].name!)
                locationString = placemarks[0].name! + ", \n" + ((placemarks[0].locality ?? "No City") + ", " + (placemarks[0].country ?? "No Country"))
                print(locationString)
            } else {
                locationString = ((placemarks[0].locality ?? "No City") + ", " + (placemarks[0].country ?? "No Country"))
            }
            return locationString
        }
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
        return locationString
    }
    
    return "Error getting Location"
}
