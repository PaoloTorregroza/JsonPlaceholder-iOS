//
//  NotesRouter.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation
import CoreData
import SwiftUI

struct UsersRouter {
    func listView(context: NSManagedObjectContext) -> some View {
        let persistence = CoreDataStack(context: context)
        let dataLayer = DataLayer(provider: persistence)
        let contentView = UsersView(presenter: UsersPresenter(interactor: UsersInteractor(model: dataLayer)))
        
        return contentView
    }
    
    func detailView(user: UserModel) -> some View {
        let persistence = CoreDataStack(context: PersistenceController.shared.container.viewContext)
        let dataLayer = DataLayer(provider: persistence)
        return UserPostsView(
            presenter: UserPostsPresenter(
                user: user,
                interactor: UserPostsInteractor(model: dataLayer, userId: user.id)
            )
        )
    }
}
