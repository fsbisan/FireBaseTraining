//
//  TaskListView.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 27.03.2023.
//

import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [String]
    
    var body: some View {
        List(tasks, id: \.self) { row in
            Text(row)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Tasks")
        .navigationBarItems(
            trailing: Button(
                action: {},
                label: {
                    Image(systemName: "plus")
                })
        )
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView(tasks: .constant(["Сделать покупки", "Пойти погулять", "выгулять собаку"]))
        }
    }
}
