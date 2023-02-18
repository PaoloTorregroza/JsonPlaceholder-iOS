//
//  UserCard.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import SwiftUI

struct UserCard: View {
    let user: UserModel
    let presenter: UsersPresenter?
    
    var body: some View {
        HStack {
            VStack {
                Text(user.name)
                    .font(.title2)
                    .foregroundColor(.teal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.teal)
                    Text(user.phone)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                }
                HStack {
                    Image(systemName: "mail.fill")
                        .foregroundColor(.teal)
                    Text(user.email)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                }
            }
            VStack {
                Spacer()
                ZStack {
                    Button(action: {}) {
                        Text("Ver Publicaciones")
                    }
                    .tint(.teal)
                    .foregroundColor(.teal)
                    
                    NavigationLink(destination: presenter?.detailView(user: user)) {
                        EmptyView()
                    }
                    .opacity(0)
                    .frame(width: 0)
                }
            }
        }
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UserCard(
                user: UserModel(id: 0, phone: "123890129823", name: "Name", email: "email@mal.com"),
                presenter: nil
            )
            UserCard(
                user: UserModel(id: 10, phone: "123890129823", name: "Name", email: "email@mal.com"),
                presenter: nil
            )
        }
    }
}
