//
//  AlertView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-06.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
        Text("Alert View")
    }
    
    func simpleAlert( title: String, message: String) -> Alert {
        Alert(
            title: Text( title ),
            message: Text( message ),
            dismissButton: .default(Text("ok")))
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
