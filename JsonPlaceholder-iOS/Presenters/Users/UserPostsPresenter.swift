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
    let user: UserModel
    
    init(user: UserModel, interactor: UserPostsInteractor) {
        self.user = user
        self.interactor = interactor
        
        interactor.$postModels
            .assign(to: \.postModels, on: self)
            .store(in: &cancellables)
    }
    
    func addNewPost(id: Int, title: String, body: String) {
        interactor.addNewPost(id: id, title: title, body: body)
    }
}
