//
//  ContentView.swift
//  LoginScreen
//
//  Created by Federico on 13/11/2021.
//

import SwiftUI

let apiUrl = "http://172.16.6.53:8080"

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Authentification")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Utilisateur", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        
                    
                    SecureField("Mot de passe", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Connexion") {
                        login(username: username, password: password)
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: MessagesView().navigationBarHidden(true), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
    
    func login(username: String, password: String) {
        guard let url = URL(string: "\(apiUrl)/api/login") else {
            return
        }
        let body: [String: Any] = [
            
            "username": username,
            "password": password
        ]
        print(body)
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        showingLoginScreen = true
                    }
                } else {
                    DispatchQueue.main.async {
                        wrongUsername = 2
                        wrongPassword = 2
                    }
                }
            }
        }.resume()
    }
}

