//
//  UsersView.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var presenter: UsersPresenter
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("User Name", text: $presenter.user)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                List {
                    ForEach (presenter.usersModels, id: \.id) { item in
                        UserCard(user: item, presenter: presenter)
                            .padding(.vertical)
                    }
                    .onDelete(perform: presenter.deleteUser)
                }
                .navigationTitle("Users")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(presenter: UsersPresenter(
            interactor: UsersInteractor(
                model: DataLayer(
                    provider: CoreDataStack(
                        context: PersistenceController.shared.container.viewContext
                    )
                )
            )
        )
        )
    }
}
