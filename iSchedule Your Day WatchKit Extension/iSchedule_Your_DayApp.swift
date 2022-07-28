//
//  iSchedule_Your_DayApp.swift
//  iSchedule Your Day WatchKit Extension
//
//  Created by MAC on 28/7/22.
//

import SwiftUI

@main
struct iSchedule_Your_DayApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            //passem les dades del controlador de Persistèncioa a les views per poder-les manejar
            //tota l'app tindrà accés a la clau: \.managedObjectContext
            .environment(\.managedObjectContext, PersistentController.shared.container.viewContext)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
