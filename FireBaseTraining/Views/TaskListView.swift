//
//  TaskListView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 27.03.2023.
//

import SwiftUI
import Firebase

struct TaskListView: View {
    @Binding var isShow: Bool
    
    @State private var user: User?
    @State private var ref: DatabaseReference!
    
    @State private var tasks: [Task] = []
    @State private var taskText = ""
    @State private var isShowAlert = false
    
    var body: some View {
        List(tasks, id: \.self) { task in
            withAnimation {
                Text(task.title)
            
            }
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
                action: {addTapped()},
                label: {
                    Image(systemName: "plus")
                })
        )
        .navigationBarTitleDisplayMode(.inline)
        .alert("Task adding", isPresented: $isShowAlert) {
            TextField("Task name", text: $taskText)
            Button("Save", action: {
                guard taskText != "" else { return }
                guard let user = user else { return }
                let task = Task(title: taskText, userId: user.uid)
                let taskRef = ref?.child(task.title.lowercased())
                taskRef?.setValue(task.convertToDictionary())
                taskText = ""
            })
            Button("Cancel", role: .cancel, action: {
                taskText = ""
            })
        } message: {
            Text("Enter task name")
        }
        .onAppear() {
            guard let currentUser = Auth.auth().currentUser else { return }
            user = User(user: currentUser)
            guard let user = user else { return }
            ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
            ref?.observe(.value) { (snapshot) in
                var _tasks: [Task] = []
                for item in snapshot.children {
                    let task  = Task(snapshot: item as! DataSnapshot)
                    _tasks.append(task)
                }
                self.tasks = _tasks
            }
        }
    }
    private func addTapped() {
        isShowAlert.toggle()
       
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
            TaskListView(isShow: .constant(true))
        }
    }
}
