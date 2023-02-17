//
//  DataLayer.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation
import Combine

class DataLayer {
    private let dataProvider: DataProvider
    private var cancellables = Set<AnyCancellable>()
    @Published var users: [User] = []
    @Published var posts: [Post] = []
    
    init(provider: DataProvider) {
        self.dataProvider = provider
        setup()
    }
    
    private func setup() {
        self.dataProvider.usersPublisher
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
        
        self.dataProvider.postsPublisher
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
    }
    
    func addNewuser(id: Int32, name: String, email: String, phone: String) {
        dataProvider.addNewUser(id: id, name: name, email: email, phone: phone)
    }
    
    func deleteUser(_ user: User) {
        dataProvider.deleteUser(user)
    }
    
    func addNewPost(userId: Int32, id: Int32, title: String, body: String) {
        dataProvider.addNewPost(userId: userId, id: id, title: title, body: body)
    }
    
    func deletePost(_ post: Post) {
        dataProvider.deletePost(post)
    }
}
