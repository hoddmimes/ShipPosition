//
//  ResponseStatus.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-26.
//

import Foundation

struct ResponseMessage :Decodable {
    let Response : Response;
    
    init( jsonString: String ) {
        self = try! JSONDecoder().decode(ResponseMessage.self, from: Data( jsonString.utf8));
    }
}

struct Response :Decodable {
    let success: Bool;
    let reason: String;
}
