//
//  UsersPostPresenter.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation
import Combine

class UserPostsPresenter: ObservableObject {
    private let interactor: UserPostsInteractor
    private var cancellables = Set<AnyCancellable>()
    @Published var postModels: [PostModel] = []
    @Published var loading = false
    let user: UserModel
    
    init(user: UserModel, interactor: UserPostsInteractor) {
        loading = true
        self.user = user
        self.interactor = interactor
        
        interactor.$postModels
            .assign(to: \.postModels, on: self)
            .store(in: &cancellables)
        loading = false
    }
    
    func addNewPost(id: Int, title: String, body: String) {
        interactor.addNewPost(id: id, title: title, body: body)
    }
}
