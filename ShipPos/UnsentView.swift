//
//  ListView.swift
//  Test
//
//  Created by Pär Bertilsson on 2023-02-11.
//

import SwiftUI
import UIKit



struct UnsentView: View {
    @State var showAlert: Bool = false
    @State var alertMessage: String  = ""
    @State var alertTitle: String  = ""
    @State var refresh: Bool = false
    
    
    var body: some View {
        Text("Unsent Positions").font(.title3).bold()
        
        List(UnsentPositions.instance.positions, id: \.self) { pos in
            PositionEntryView(position: pos).swipeActions {
                Button {
                    let httpUpload = PostPositionUpdate(position: pos)
                    httpUpload.send(completionHandler: uploadComplete )
                    refresh.toggle()
                } label: {
                    Label("Upload", systemImage: "square.and.arrow.up.fill")
                }.tint(.green)
                Button {
                    UnsentPositions.instance.remove(position: pos)
                    alertMessage = "position successully removed"
                    alertTitle = ""
                    showAlert = true
                    refresh.toggle()
                } label: {
                    Label("remove", systemImage: "trash.slash.fill")
                }.tint(.red)
            }
        }.alert(isPresented: $showAlert ) {
            let a = AlertView()
            return a.simpleAlert(title: alertTitle, message: alertMessage)
            refresh.toggle()
        }
        Spacer()
        
    }
    
    func uploadComplete( result : Result<String?, HttpError>, position: Position ) {
        switch result {
        case .success:
            alertTitle = "Upload Success"
            alertMessage = "Date \(position.mmsi) \n lat \(position.lat) long \(position.long)"
            UnsentPositions.instance.remove( position: position)
        case .failure(let error):
            alertTitle = "Upload Failure"
            alertMessage = "Failure code: \(error.code) msg: \(error.message)"
        }
        showAlert = true
            
    }
}

struct PositionEntryView: View {
    var position: Position
    
    init(position: Position) {
        self.position = position
    }
    
    var body: some View {
        
        VStack {
            let tDate = position.date.replacingOccurrences(of: "Z", with: " ")
                                     .replacingOccurrences(of: "T", with: " ")
            Text("**Date** \(tDate)")
            Text("**lat** \(position.lat)   **long** \(position.long)")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        UnsentView()
    }
}
