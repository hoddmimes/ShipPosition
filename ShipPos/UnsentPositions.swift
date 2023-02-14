//
//  UnsentPositions.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-10.
//

import Foundation

struct UnsentPositions: Codable, Hashable
{
    static var instance = UnsentPositions()
    
    var positions: [Position]
    
     init() {
        let jsonString = UserDefaults.standard.string(forKey: "unsent") ?? "{\"positions\":[]}"
        self = try! JSONDecoder().decode(UnsentPositions.self, from: Data(jsonString.utf8))
       
    }

     init( jsonString: String ) {
        self = try! JSONDecoder().decode(UnsentPositions.self, from: Data(jsonString.utf8))
    }
    
    mutating func remove( position: Position ) {
        if let idx = positions.firstIndex(where: {  $0.equal(position: position)  }) {
            positions.remove(at: idx)
            save()
        }
    }
    mutating func add( position: Position) {
        positions.append(position)
        save()
    }
    
    func toString() -> String {
        let jsonEncoder = JSONEncoder()
        let json = try! jsonEncoder.encode(self)
        return String(data: json, encoding: .utf8)! // return Json String
    }
    
    func save() {
        let jsonString = self.toString()
        UserDefaults.standard.set(jsonString, forKey: "unsent")
    }
}
