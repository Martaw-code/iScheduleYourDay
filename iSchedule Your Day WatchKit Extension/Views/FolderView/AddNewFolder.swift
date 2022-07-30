//
//  AddNewFolder.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 28/7/22.
//

import SwiftUI

struct AddNewFolder: View {
    
    @State private var folderTitle = ""
    @State private var selectedColor = "blau"
    
    private var folderColors = ["blau", "lila", "taronja" , "verd", "vermell"]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationM
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Nom Folder...", text: $folderTitle)
            
            HStack {
                ForEach(folderColors, id: \.self)  { colorName in //identifica unívocament cada element que es processa: \.self
                    Circle()
                        .fill(Color(colorName))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle().stroke(Color.white,lineWidth: selectedColor == colorName ? 2 : 0)
                        )
                        .onTapGesture {
                            selectedColor = colorName
                        }
                        .padding(.vertical)
                }
            } .padding(.horizontal)
            
            Button(action: addFolder) {
                Text("Afegeix Folder")
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(folderTitle == "")
        }
        .navigationTitle("Afegeix nou Folder")
    }
    
    private func addFolder() {
        let folder = Folder(context: context)
        folder.title = folderTitle
        folder.dataAdded = 	Date()
        folder.colorString = selectedColor
        
        do {
            try context.save()
            presentationM.wrappedValue.dismiss()
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

struct AddNewFolder_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFolder()
    }
}
