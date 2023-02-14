//
//  SettingsView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-04.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: Settings

    init() {
        settings = Settings.instance
       
    }
    var body: some View {
        Form(content: {
            Section(header: Text("Settings")) {
                Text("MMSI")
                TextField("MMSI", text: $settings.mmsi,
                          onEditingChanged: {
                            if !$0 {
                                print("setting MMSI \(Settings.instance.mmsi)")
                                Settings.instance.saveMMSI()
                            }
                          },
                          onCommit: {
                            print("setting MMSI \(Settings.instance.mmsi)")
                            Settings.instance.saveMMSI()
                          })
                    .padding(20.0)
                
                
                Text("Password")
                SecureField("Password", text: $settings.password,
                            onCommit: {
                                print("setting password \(Settings.instance.password)")
                                Settings.instance.savePassword()
                            }).padding(20.0)
                
               
                Toggle("Auto update", isOn: $settings.autoUpdate).onReceive([settings.autoUpdate].publisher.first())
                { (value) in
                    print("setting auto update \(Settings.instance.autoUpdate)")
                    Settings.instance.saveAutoUpdate()
                    
                }
                if settings.autoUpdate {
                  Group {
                    Text("Automatic Update Frequency")
                    TextField("", value: $settings.updateFrequencyHours, formatter: NumberFormatter(),
                        onEditingChanged: {
                            if !$0 {
                                print("setting update frequency hours \(Settings.instance.updateFrequencyHours)")
                                Settings.instance.saveUpdateFrequencyHours()
                            }
                        },
                        onCommit: {
                            print("setting update frequency hours \(Settings.instance.updateFrequencyHours)")
                            Settings.instance.saveUpdateFrequencyHours()
                        })
                        .keyboardType(UIKeyboardType.decimalPad)
                        .padding(20.0)
                  }
                }
                
            }
        })
    }
}
    
   
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
