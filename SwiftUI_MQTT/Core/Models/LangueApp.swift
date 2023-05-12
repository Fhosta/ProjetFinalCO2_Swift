//
//  LangueApp.swift
//  SwiftUI_MQTT
//
//  Created by Florian on 2023-05-11.
//

import Foundation
class LanguageAppState: ObservableObject {
    @Published var appLanguage: String = ""

    func setAppLanguage(language: String) {
        appLanguage = language
    }
}
