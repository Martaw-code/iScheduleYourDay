//
//  PersistentController.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 28/7/22.
//

import Foundation
import CoreData

struct PersistentController { //singleton
    
    //compartida entre tota l'aplicació
    static let shared = PersistentController()
    
    let container : NSPersistentContainer
    
    init(inMemory : Bool = false) {
        //Inicialitzem el contenidor
        container = NSPersistentContainer(name: "doit") //el nom que passem per paràmetre correspon al nom del nostre model de dades
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores  { (storeDesc, error) in //altrament carreguem el que es guarda
            if let error = error as NSError?  {
                //si la nostra core data no està inicialitzada, no té cap sentit que seguim, llançem una excepció i concloem l'execució
                fatalError("Failed to load container \(error)")
            }
        }
    }
}
