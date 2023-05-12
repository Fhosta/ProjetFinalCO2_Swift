//
//  MQTTAppState.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-19.
//

import Combine
import Foundation

enum MQTTAppConnectionState {
    case connected
    case disconnected
    case connecting
    case connectedSubscribed
    case connectedUnSubscribed

    var description: String {
        switch self {
        case .connected:
            return "Connecté".localized
        case .disconnected:
            return "Déconnecté".localized
        case .connecting:
            return "Connection".localized
        case .connectedSubscribed:
            return "Souscrit".localized
        case .connectedUnSubscribed:
            return "Connexion Desouscrire".localized
        }
    }
    var isConnected: Bool {
        switch self {
        case .connected, .connectedSubscribed, .connectedUnSubscribed:
            return true
        case .disconnected,.connecting:
            return false
        }
    }
    
    var isSubscribed: Bool {
        switch self {
        case .connectedSubscribed:
            return true
        case .disconnected,.connecting, .connected,.connectedUnSubscribed:
            return false
        }
    }
}

final class MQTTAppState: ObservableObject {
    @Published var appConnectionState: MQTTAppConnectionState = .disconnected
    @Published var historyText: String = ""
    private var receivedMessage: String = ""

    func setReceivedMessage(text: String) {
        receivedMessage = text
        historyText = historyText + "\n" + receivedMessage
    }

    func clearData() {
        receivedMessage = ""
        historyText = ""
    }

    func setAppConnectionState(state: MQTTAppConnectionState) {
        appConnectionState = state
    }
}
