//
//  UsersPresenter.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import SwiftUI
import Combine

class UsersPresenter: ObservableObject {
    private let interactor: UsersInteractor
    private let router = UsersRouter()
    private var cancellables = Set<AnyCancellable>()
    private var allUsers: [UserModel] = [] {
        didSet {
            usersModels = allUsers
        }
    }
    @Published var usersModels: [UserModel] = []
    @Published var user: String = "" {
        didSet {
            filterUsers()
        }
    }
    
    init(interactor: UsersInteractor) {
        self.interactor = interactor
        
        interactor.$userModels
            .assign(to: \.allUsers, on: self)
            .store(in: &cancellables)
    }
    
    func addNewUser(id: Int, name: String, email: String, phone: String) {
        interactor.addNewUser(id: id, name: name, email: email, phone: phone)
    }
    
    func deleteUser(index: IndexSet) {
        interactor.deleteUser(index)
    }
    
    func detailView(user: UserModel) -> some View {
        router.detailView(user: user)
    }
    
    func filterUsers() {
        if user == "" {
            usersModels = allUsers
            return
        }
        usersModels = allUsers.filter { el in
            return el.name.contains(user)
        }
    }
}
