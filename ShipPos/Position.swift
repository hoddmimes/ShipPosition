//
//  File.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-07.
//

import Foundation
import UIKit


struct Position : Codable, Hashable
{
    let  mmsi: String
    let  password: String
    let  lat: Double
    let  long: Double
    var  date: String
    
    init( mmsi: String, password: String, lat: Double, long: Double ) {
        let date_time = NSDate()
        let dateFormater = DateFormatter()
         dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
         dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
         date = dateFormater.string(from: date_time as Date)
        self.lat = lat
        self.long = long
        self.password = password
        self.mmsi = mmsi
    }
    
    func equal( position: Position ) -> Bool {
        if self.date == position.date &&
            self.lat == position.lat &&
            self.long == position.long
        {
            return true
        } else {
            return false
        }
    }
}
