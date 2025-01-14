//
//  Location.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation
import SwiftEventBus

class Location {
    
    func oneShot(completion:(coords:CLLocationCoordinate2D) -> Void ){
        
        do {
            
            try SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 20, onSuccess: { (location) -> Void in
                // location is a CLPlacemark
                
                let myCoords = location?.coordinate
            
                print(myCoords)
                
                completion(coords: myCoords!)
                
                }) { (error) -> Void in
                    
                    // something went wrong
            }
            
        }catch _{
            
        }
        
    }
    
    func reverseAddress(myAddress:String,completion:(lat:Double,long:Double) -> Void) {
        
        var lat:Double!
        var long:Double!
        
        SwiftLocation.shared.reverseAddress(Service.Apple, address: myAddress, region: nil, onSuccess: { (place) -> Void in
            // our CLPlacemark is here
            
            if place?.country == "United States" {
                
                lat = place?.location?.coordinate.latitude
                long = place?.location?.coordinate.longitude
                
            }
            
            if lat != nil && long != nil {
                
                completion(lat: lat!, long: long!)
                
            }else {
                
                print("This Is Not A Valid US Region")
                SwiftEventBus.post("signUp", sender: false)
    
            }
            
        
            }) { (error) -> Void in
                // something went wrong
                
                 print("Couldn't Find Address")
                 print("Getting Current Location")
                self.oneShot({ (coords) -> Void in
                    
                    lat = coords.latitude
                    long = coords.longitude
                    completion(lat: lat!, long: long!)
                    
                    print("Got Current Location")
                })
        }
    }
    
    func reverseCoordinates(long:Double,lat:Double){
        
        let coordinates = CLLocationCoordinate2DMake(41.890198, 12.492204)
        
        SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: coordinates, onSuccess: { (place) -> Void in
            // our placemark is here
            }) { (error) -> Void in
                // something went wrong
        }
    }
    
}