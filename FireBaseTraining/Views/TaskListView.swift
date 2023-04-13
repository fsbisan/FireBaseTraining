//
//  TaskListView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 27.03.2023.
//

import SwiftUI
import Firebase

struct TaskListView: View {
    @Binding var tasks: [String]
    @Binding var isShow: Bool
    @State private var taskText = ""
    @State private var isShowAlert = false
    
    var body: some View {
        List(tasks, id: \.self) { row in
            Text(row)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Tasks")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(
                action: signOut,
                label: {
                    Text("Sign Out")
                }),
            trailing: Button(
                action: {isShowAlert.toggle()},
                label: {
                    Image(systemName: "plus")
                })
        )
        .navigationBarTitleDisplayMode(.inline)
        .alert("Task adding", isPresented: $isShowAlert) {
            TextField("Task", text: $taskText)
            Button("Login", action: {})
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Enter task name")
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        isShow.toggle()
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView(tasks: .constant(["Сделать покупки", "Пойти погулять", "выгулять собаку"]), isShow: .constant(true))
        }
    }
}
