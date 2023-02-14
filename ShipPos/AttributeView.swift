//
//  AttributeView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-04.
//

import SwiftUI



struct AttributeView: View {
    @State var name: String = ""
    @State var value: String = ""
    
    var body: some View {
        VStack {
            Text("\(name)")
            TextField("", text:$value)
        }
    }
}

struct AttributeView_Previews: PreviewProvider {
    static var previews: some View {
        AttributeView()
    }
}
