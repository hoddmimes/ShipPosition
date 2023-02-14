//
//  AppNavigationView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-03.
//

import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        NavigationView {
            VStack{
              Text("").navigationBarItems(trailing:
                 HStack {
                    NavigationLink( destination: UnsentView(),
                                    label: {Image(systemName: "list.bullet")})
                    NavigationLink( destination: HelpView(),
                                    label: {Image(systemName: "questionmark.circle")})
                    NavigationLink( destination: SettingsView(),
                                    label: {Image(systemName: "gearshape")})
            
                })
              PositionView()
            }
        }
    }
}
                


struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}

