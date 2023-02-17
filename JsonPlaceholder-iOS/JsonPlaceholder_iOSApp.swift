//
//  JsonPlaceholder_iOSApp.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import SwiftUI

@main
struct JsonPlaceholder_iOSApp: App {
    let persistenceController = PersistenceController.shared
    let router = UsersRouter()

    var body: some Scene {
        WindowGroup {
            router.listView(context: persistenceController.container.viewContext)
        }
    }
}
