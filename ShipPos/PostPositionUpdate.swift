//
//  PostPositionUpdate.swift
//  Test
//
//  Created by Pär Bertilsson on 2023-02-08.
//

import Foundation

struct HttpError: Error {

    var message: String
    var code: Int

    init(message: String, code: Int) {
        self.message = message
        self.code = code
    }
}

class PostPositionUpdate {
    let position: Position
    var jsonRqstString = "";
    
    
    init( position: Position ){
        self.position = position
    }
    
    func convertStringToDictionary(text: String) -> [String:Any]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    func send( completionHandler: @escaping (Result<String?, HttpError>, Position ) -> Void) {
        let rqstDict : [String: Any] = ["mmsi" : position.mmsi,
                                       "lat" : position.lat,
                                       "long" : position.long,
                                       "date" : position.date,
                                       "password" : position.password ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: rqstDict, options: [])
        
        jsonRqstString = String(data: jsonData!, encoding: String.Encoding.utf8)!;
        
        // Post data
        let url = URL(string: "https://hoddmimes.com/sailtracker/app/phonepos")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))",
                         forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                let httpError = HttpError( message: error!.localizedDescription, code:0)
                completionHandler(Result.failure(httpError), self.position)
                return
            }
            
            let response = response as! HTTPURLResponse
        
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completionHandler(Result.failure(HttpError(message: "Server error", code:status)),
                                                 self.position)
                return
            }
            let jString = String(decoding: data!, as: UTF8.self)
        
           
            completionHandler(Result.success(jString), self.position)
        }
        task.resume()
    }
    
   
    
}
