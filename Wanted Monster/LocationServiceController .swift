//
//  LocationServiceController .swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 18/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServiceController {
    var coordonate : CLLocationCoordinate2D{
        didSet{
            placemark = nil
        }
    }
    
    private(set) var placemark: CLPlacemark?
    var location: CLLocation{
        return CLLocation(latitude : self.coordonate.latitude, longitude : self.coordonate.longitude)
    }
    
    var formatedAddress: String?{
        if let placemark = placemark{
            return "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "") \n \(placemark.subLocality ?? "") \n \(placemark.locality ?? "")"
        }else{
            return nil
        }
    }
    
    init(latitude : Double, longitude : Double){
        
        self.coordonate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func fetchPlacemark(completionHandler: @escaping (Bool, Error?) -> Void){
        CLGeocoder().reverseGeocodeLocation(self.location){ (placemarks, error) in
            self.placemark = placemarks?.first
            completionHandler(self.placemark != nil, error)
        }
    }
}
