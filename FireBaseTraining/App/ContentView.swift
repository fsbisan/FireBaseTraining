//
//  ContentView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 24.03.2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
