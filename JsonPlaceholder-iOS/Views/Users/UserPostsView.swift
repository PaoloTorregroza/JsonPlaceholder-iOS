//
//  UserPostsView.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import SwiftUI

struct UserPostsView: View {
    @ObservedObject var presenter: UserPostsPresenter
    
    var body: some View {
        VStack() {
            Text(presenter.user.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text(presenter.user.email)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text(presenter.user.phone)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            List {
                ForEach (presenter.postModels, id: \.id) { item in
                    VStack {
                        Text(item.title)
                            .font(.title2)
                        Text(item.body)
                    }
                }
            }
        }
    }
}

struct UserPost_Previews: PreviewProvider {
    static var previews: some View {
        UserPostsView(
            presenter: UserPostsPresenter(
                user: UserModel(
                    id: 0,
                    phone: "123211 213 x12",
                    name: "John",
                    email: "mal@mail.com"
                ),
                interactor: UserPostsInteractor(
                    model: DataLayer(
                        provider: CoreDataStack(
                            context: PersistenceController.shared.container.viewContext
                        )
                    ),
                    userId: 0
                )
            )
        )
    }
}
