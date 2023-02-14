//
//  PositionView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-03.
//

import SwiftUI
import CoreLocation
import Foundation

class PositionData: ObservableObject
{
    @Published var latValue: String = ""
    @Published var longValue: String = ""
}

class AlertData: ObservableObject
{
    @Published var show: Bool = false
    @Published var message: String = ""
}






struct PositionView: View {
    @ObservedObject private var posData: PositionData
    @State private var  timer = HandyTimer()
    @State var locManager: CLLocationManager
    @State var count: Int = 0
    @State var starts: Int = 0
    
    
    @ObservedObject private var alert: AlertData = AlertData()
    
    
    init() {
        locManager = CLLocationManager()
        posData = PositionData()
        locManager.requestWhenInUseAuthorization()
        
        setLatLong()
        
        
    }

    var body: some View {
        
        VStack {
            //Text("Count [ \(count) ]   starts [ \(starts) ]")
            HStack {
                Text("Lat")
                    .frame(width: 80.0)
                TextField("lat", text: $posData.latValue)
                   
            }.padding(.leading, 40.0)
            
            HStack {
                Text("Long")
                    .frame(width: 80.0)
                TextField("long", text: $posData.longValue)
                   
            }.padding(.leading, 40.0)
                
            VStack {
            Button(action: {uploadPosition()}) {
                        Text("Upload")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                    )
                }
                
                .background(Color.gray) // If you have this
                .cornerRadius(25)
            }.padding(.top, 60.0)
        }
        .alert( isPresented: $alert.show ) {
            let a = AlertView()
            return a.simpleAlert(title: "", message: alert.message)
        }
        .onDisappear{
            timer.stop()
        }
        .onAppear {
            starts = starts + 1
            timer.start(withTimeInterval: 10, repeats: true, onFire: timerEvent)
        }.padding()
    }
    

    
    func uploadPosition() {
        let position = Position(mmsi: Settings.instance.mmsi,
                                password: Settings.instance.password,
                                lat: Double(posData.latValue)!,
                                long: Double(posData.longValue)!)
        
        let http = PostPositionUpdate( position: position )
        http.send( completionHandler: httpComplete)
    }
        
    func httpComplete( result: Result<String?,  HttpError>, position: Position  ) {
        switch result {
            case .success(let jResponse):
                let rspsts = ResponseMessage(jsonString: jResponse!)
                if (!rspsts.Response.success) {
                    UnsentPositions.instance.add(position: position)
                }
                alert.message = rspsts.Response.reason;
                alert.show = true
            case .failure(let error):
               print("Post Request failed, reason: \(error.message) status: \(error.code)")
               alert.message = "Upload failure: \(error.message) status: \(error.code)\n Position saved as unsent"
               alert.show = true
               UnsentPositions.instance.add(position: position)
        }
    }
    
    
    func timerEvent() {
        DispatchQueue.main.async {
           setLatLong()
        }
    }
    
    
    func setLatLong()
    {
        count = count + 1
#if targetEnvironment(simulator)
        posData.longValue = "17.937857"
        posData.latValue = "59.322386"
#else
        let locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    posData.latValue = "no access"
                    posData.longValue = "no access"
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    let  currentLocation: CLLocation!
                    currentLocation = locManager.location    
                    posData.longValue = "\(currentLocation.coordinate.longitude)"
                    posData.latValue = "\(currentLocation.coordinate.latitude)"
                    print("Access")
                @unknown default:
                    break
            }
        } else {
            posData.latValue = "not available"
            posData.longValue = "not available"
            print("Location services are not enabled")
        }
     
#endif
    }


struct PositionView_Previews: PreviewProvider {
    static var previews: some View {
        PositionView()
    }
}
}
