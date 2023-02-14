//
//  HelpView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-05.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        WebView(url: URL( string: "https://www.hoddmimes.com/sailtracker/shipposhelp.html")!).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
