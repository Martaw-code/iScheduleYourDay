//
//  FolderView.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 28/7/22.
//

import SwiftUI

struct FolderView: View {
    //fem un fetch dels folder i els ordenem amb l'artibut de dataAdded que és de tipus Date
    @FetchRequest(entity: Folder.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Folder.dataAdded, ascending: false)], animation: .easeInOut)
    
    var results : FetchedResults<Folder> //guardem els resultats (que són de tipus Folder obtinguts amb el fetch
    
    var body: some View {
        List {
            ForEach(results) { item in
                HStack { //layout horitzontal i hem de mostrar cada item(i.e Folder)
                    NavigationLink(
                        destination: TodoListView(folderName: item.title ?? "", accentColor: item.colorString ?? "blau"), //MANTENIM EL MATEIX COLOR PER LES LLISTES DE DINS DE LA CARPETA
                        label: {
                            Text(item.title ?? "") //i si és buit(??), que es mostri ""
                        })
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .contentShape(Rectangle())
                    .background(
                        LinearGradient(
                            gradient:
                                Gradient(colors:
                                            [Color(item.colorString ?? "blau"),
                                             Color(item.colorString ??
                                                   "blau").opacity(0.7),
                                             Color(item.colorString ?? "blau")]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .cornerRadius(15)
                }
            }
            //afegir un nou Folder al final
            NavigationLink( //botó que fa el trigger
            destination: AddNewFolder(),
            label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Nou Folder")
                    Spacer()
                }
            })
        }
        .listStyle(CarouselListStyle()) //per defecte podem usar aquest
        .navigationTitle("Folders")
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
