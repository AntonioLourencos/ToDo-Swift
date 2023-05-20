//
//  ContentView.swift
//  to-do
//
//  Created by Antonio Lourencos on 19/05/23.
//

import SwiftUI

struct Task {
    let id: Int
    var payload: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTask: String = ""

    func handleCreateTask() {
        if newTask.isEmpty {
            return
        }

        tasks.append(
            Task(
                id: tasks.count,
                payload: newTask,
                isDone: false
            )
        )

        newTask = ""
    }

    func handleUpdateStatus(id: Int) {
        if let task = tasks.firstIndex(where: { $0.id == id }) {
            tasks[task].isDone = !tasks[task].isDone
        }
    }

    func handleDelete(id: Int) {
        if let task = tasks.firstIndex(where: { $0.id == id }) {
            tasks.remove(at: task)
        }
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("My Tasks").font(.largeTitle)
                }

                HStack {
                    TextField(
                        "New Task",
                        text: $newTask
                    )
                    Button(action: handleCreateTask) {
                        Text("Create Task")
                    }
                }
            }

            ScrollView {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            handleUpdateStatus(id: tasks[index].id)
                        }) {
                            Text(tasks[index].payload)
                                .foregroundColor(.black)
                                .strikethrough(tasks[index].isDone, color: Color.red)
                        }

                        Spacer()

                        Button(action: {
                            handleDelete(id: tasks[index].id)
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                        }
                    }
                    .padding(6)
                }
            }
        }

        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
