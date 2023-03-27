//
//  LoginView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 24.03.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var loginText = ""
    @State private var passwordText = ""
    
    var body: some View {
        VStack {
            TextField("", text: $loginText, prompt: Text("Введите email"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            TextField("", text: $passwordText, prompt: Text("Введите пароль"))
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 16)
                .controlSize(.large)
            
            Button("Отправить") {
                
            }
            .buttonStyle(.borderedProminent)
            
            Button("Зарегистрироваться") {
                
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.mini)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(.mint)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
