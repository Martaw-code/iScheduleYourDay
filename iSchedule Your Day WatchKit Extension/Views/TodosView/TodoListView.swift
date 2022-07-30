//
//  TodoListView.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 30/7/22.
//

import SwiftUI

struct TodoListView: View {
    var accentColor: String
    var folderName: String
    
    @FetchRequest var results : FetchedResults<Todo>
    
    init(folderName: String, accentColor: String) {
        self.accentColor = accentColor
        self.folderName = folderName
        
        //inicialitzar els resultats: fa la where condition per la query
        let predicate = NSPredicate(format: "folder == %@", folderName)
        self._results = FetchRequest(
            entity: Todo.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Todo.dataAdded, ascending: false)],
            predicate: predicate,
            animation: .easeInOut)
    }
    
    var body: some View {
        List {
            ForEach(results) { item in
                HStack {
                    NavigationLink(
                        destination: AddNewTodo(todoItem: item, accentColor: accentColor, folderName: folderName),
                        label: {
                            Text(item.title ?? "")
                                .bold()
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .contentShape(Rectangle())
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(accentColor), Color(accentColor).opacity(0.8), Color(accentColor)]), startPoint: .top, endPoint: .bottom), lineWidth: 4))
            }
        }
        NavigationLink(
            destination: AddNewTodo(accentColor: accentColor, folderName: folderName),
            label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Nou Todo")
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(accentColor))
                        .frame(height: 20)
                )
            })
        } .listStyle(CarouselListStyle())
            .navigationTitle(folderName)
    }
}
