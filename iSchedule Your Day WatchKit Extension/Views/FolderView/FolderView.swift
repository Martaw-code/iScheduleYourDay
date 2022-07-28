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
                        destination: Text(item.title ?? ""),
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
                    .cornerRadius(5)
                }
            }
            //afegir un nou Folder al final
            NavigationLink(
            destination: Text("Afegeix un nou Folder"),
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
