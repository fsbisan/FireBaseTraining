//
//  LoginView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 24.03.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var loginText = ""
    @State private var passwordText = ""
    @State private var warningText = ""
    @State private var isTaskListOpen = false
    @State private var ref = Database.database().reference(withPath: "users")
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $isTaskListOpen) {
                TaskListView(isShow: $isTaskListOpen)
            } label: {
                EmptyView()
            }
            Text("To Do Fire")
                .font(.system(size: 30))
            Text(warningText)
                .foregroundColor(.red)
                .opacity(1)
            TextField("", text: $loginText, prompt: Text("Введите email"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            SecureField("", text: $passwordText, prompt: Text("Введите пароль"))
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 16)
                .controlSize(.large)
            
            Button("Отправить") {
                loginTapped()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Зарегистрироваться") {
                registerTapped()
            }
            
            .controlSize(.mini)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(.mint)
        .onAppear() {
            loginText = ""
            passwordText = ""
            Auth.auth().addStateDidChangeListener { auth, user in
                if user  != nil {
                    isTaskListOpen.toggle()
                }
            }
        }
    }
    
    private func loginTapped() {
        guard loginText != "", passwordText != "" else { return }
        Auth.auth().signIn(withEmail: loginText, password: passwordText) { user, error in
            if error != nil {
                withAnimation {
                    self.warningText = "Error occured"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {warningText = ""})
                }
                return
            }
            if user != nil {
                isTaskListOpen.toggle()
                return
            }
            warningText = "No such user"
        }
    }
    
    private func registerTapped() {
        guard loginText != "", passwordText != "" else { return }
        Auth.auth().createUser(withEmail: loginText, password: passwordText) { user, error in
            guard error == nil, user != nil else {
                print(error?.localizedDescription ?? "unown error")
                return
            }
            
            let userRef = ref.child((user?.user.uid)!)
            userRef.setValue(["email": user?.user.email])
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
