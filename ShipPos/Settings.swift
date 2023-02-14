//
//  Settings.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-05.
//

import Foundation

class Settings: ObservableObject
{
    static var instance = Settings()
    
    @Published var mmsi: String = ""
    @Published var password: String = ""
    @Published var autoUpdate: Bool = false
    @Published var updateFrequencyHours: Int = 0
    
     init() {
        self.autoUpdate = UserDefaults.standard.bool(forKey: "autoUpdate")
        self.updateFrequencyHours = UserDefaults.standard.integer(forKey: "updateFrequencyHours")
        self.mmsi = UserDefaults.standard.string(forKey: "mmsi") ?? ""
        self.password = UserDefaults.standard.string(forKey: "password") ?? ""
    }
    
    func saveMMSI() {
        UserDefaults.standard.set(Settings.instance.mmsi, forKey: "mmsi")
    }
    
    func savePassword() {
        UserDefaults.standard.set(Settings.instance.password, forKey: "password")
    }
    
    func saveAutoUpdate() {
        UserDefaults.standard.set(Settings.instance.autoUpdate, forKey: "autoUpdate")
    }
    
    func saveUpdateFrequencyHours() {
        UserDefaults.standard.set(Settings.instance.autoUpdate, forKey: "updateFrequencyHours")
    }
}
