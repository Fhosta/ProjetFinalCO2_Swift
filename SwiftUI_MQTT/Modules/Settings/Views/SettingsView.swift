//
//  SettingsView.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-20.
//

import SwiftUI

struct SettingsView: View {
    @State var topic: String = ""
    @State var CO2Min: String = ""
    @State var CO2Max: String = ""
    @State var TVOCMin: String = ""
    @State var TVOCMax: String = ""
    @State var topic2: String = ""
    @State var brokerAddress: String = ""
    @EnvironmentObject private var mqttManager: MQTTManager
    var body: some View {
        VStack {
            ConnectionStatusBar(message: mqttManager.connectionStateMessage(), isConnected: mqttManager.isConnected())
            VStack
            {
                HStack{
                    MQTTTextField(placeHolderMessage: "Entré l'adresse du broker", isDisabled: mqttManager.currentAppState.appConnectionState != .disconnected, message: $brokerAddress)
                    setUpConnectButton()
                    setUpDisconnectButton()
                }.padding(.vertical,30)
                HStack{
                    MQTTTextField(placeHolderMessage: "Enter a topic to subscribe", isDisabled: !mqttManager.isConnected() || mqttManager.isSubscribed(), message: $topic)
                    MQTTTextField(placeHolderMessage: "Enter a topic to subscribe", isDisabled: !mqttManager.isConnected() || mqttManager.isSubscribed(), message: $topic2)
                    Button(action: functionFor(state: mqttManager.currentAppState.appConnectionState)) {
                        Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                            .font(.system(size: 14.0))
                    }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                        .frame(width: 100)
                        .disabled(!mqttManager.isConnected() || topic.isEmpty)
                }
                    Text("CO2 MINIMUM :")
                        .font(.system(size:10))
                        .bold()
                        .padding()
                    
                    TextField("CO2 min", text: $CO2Min)
                        .padding()
                        .frame(width: 200, height: 35)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Text("CO2 MAXIMUM :")
                        .font(.system(size:10))
                        .bold()
                        .padding()
                    
                    TextField("CO2 max", text: $CO2Max)
                        .padding()
                        .frame(width: 200, height: 35)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Text("TVOC MINIMUM:")
                        .font(.system(size:10))
                        .bold()
                        .padding()
                    
                    TextField("TVOC min", text: $TVOCMin)
                        .padding()
                        .frame(width: 200, height: 35)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Text("TVOC MAXIXUM :")
                        .font(.system(size:10))
                        .bold()
                        .padding()
                    
                    TextField("TVOC max", text: $TVOCMax)
                        .padding()
                        .frame(width: 200, height: 35)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
        }
            HStack{
                Button(action: {
                    updateSettings()
                }) {
                    Text("Mettre à jour les paramètres")
                        .font(.system(size: 14.0))
                }
                .buttonStyle(BaseButtonStyle(foreground: .white, background: .blue))
                .frame(width: 200, height: 35)
                .disabled(!mqttManager.isConnected())
        }
        .navigationTitle("Réglages")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    private func updateSettings() {
        guard let url = URL(string: "http://172.16.6.53:8080/api/parametre") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let settings = ["CO2Max": CO2Max, "CO2Min": CO2Min, "TVOCMin": TVOCMin, "TVOCMax": TVOCMax]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: settings, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: (error.localizedDescription)")
            }
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonResponse)
            } catch let error {
                print("Error: (error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func setUpConnectButton() -> some View  {
        return Button(action: { configureAndConnect() }) {
                Text("Connexion")
            }.buttonStyle(BaseButtonStyle(foreground: .white, background: .blue))
        .disabled(mqttManager.currentAppState.appConnectionState != .disconnected || brokerAddress.isEmpty)
    }
    
    private func setUpDisconnectButton() -> some View  {
        return Button(action: { disconnect() }) {
            Text("Deconnexion")
        }.buttonStyle(BaseButtonStyle(foreground: .white, background: .red))
        .disabled(mqttManager.currentAppState.appConnectionState == .disconnected)
    }
    private func configureAndConnect() {
        // Initialize the MQTT Manager
        mqttManager.initializeMQTT(host: brokerAddress, identifier: UUID().uuidString)
        // Connect
        mqttManager.connect()
    } 

    private func disconnect() {
        mqttManager.disconnect()
    }
    
    private func titleForSubscribButtonFrom(state: MQTTAppConnectionState) -> String {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return "Subscribe"
        case .connectedSubscribed:
            return "Unsubscribe"
        }
    }
    
    private func subscribe(topic: String) {
        mqttManager.subscribe(topic: topic)
        mqttManager.subscribe(topic: topic2)
    }

    private func usubscribe() {
        mqttManager.unSubscribeFromCurrentTopic()
    }

    private func functionFor(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: topic) }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
