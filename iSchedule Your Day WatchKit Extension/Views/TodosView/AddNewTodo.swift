//
//  AddNewTodo.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 30/7/22.
//

import SwiftUI

struct AddNewTodo: View {
    
    var todoItem: Todo?
    
    var accentColor: String
    var folderName: String
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationM
    
    @State private var todoTitle = ""
      
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Afegeix nou Todo...", text: $todoTitle)
            
            Button(action: addUpdateTodo) {
                Text(todoItem == nil ? "Afegeix Todo" : "Update")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(accentColor))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(todoTitle == "")
            
            Button(action: deleteTodo) {
                Text("Esborra")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .opacity(todoItem == nil ? 0.0 : 1.0) //mostrem o no el botó i directament ho fem amb la opacitat, així més easy
        }
        .navigationTitle(todoItem == nil ? "Afegeix Todo" : "Update Todo")
        .onAppear {
            if let todo = todoItem {
                todoTitle = todo.title ?? ""
                
            }
        }
    }
    
    private func addUpdateTodo() {
        let todo = todoItem == nil ? Todo(context: context) : todoItem
        todo?.title     = todoTitle
        todo?.dataAdded = Date()
        todo?.folder    = folderName
        
        do {
            try context.save()
            presentationM.wrappedValue.dismiss()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func deleteTodo() {
        if let todo = todoItem {
            context.delete(todo)
            do {
                try context.save()
            } catch let err {
                print(err.localizedDescription)
            }
            presentationM.wrappedValue.dismiss()
        }
    }
}

