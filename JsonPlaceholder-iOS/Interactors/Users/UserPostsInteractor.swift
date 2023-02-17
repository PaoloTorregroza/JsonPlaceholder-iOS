//
//  UserPostsInteractor.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation
import Combine
import Alamofire

class UserPostsInteractor {
    private let localData: DataLayer
    private var cancellables = Set<AnyCancellable>()
    private var currentUserId: Int
    @Published var postModels: [PostModel] = []
    
    init(model: DataLayer, userId: Int) {
        self.localData = model
        self.currentUserId = userId
        
        setup()
    }
    
    private func setup() {
        self.localData.$posts
            .map({posts -> [PostModel] in
                let filtered = posts.filter { el in
                    el.userId == self.currentUserId
                }
                return filtered.map({
                    PostModel(userId: Int($0.userId), id: Int($0.id), title: $0.title!, body: $0.body!)
                })
            })
            .replaceError(with: [])
            .assign(to: \.postModels, on: self)
            .store(in: &cancellables)
        
        if postModels.count == 0 {
            loadRemote()
        }
    }
    
    private func loadRemote() {
        let req = AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(currentUserId)", encoding: JSONEncoding.default)
        
        req.responseDecodable(of: Array<PostModel>.self) { response in
            switch response.result {
            case .failure:
                print("Error Loading Posts")
            case .success:
                guard let data = response.value else { return }
                self.postModels = data
                
                for post in data {
                    self.addNewPost(id: post.id, title: post.title, body: post.body)
                }
            }
        }
    }
    
    func addNewPost(id: Int, title: String, body: String) {
        localData.addNewPost(userId: Int32(currentUserId), id: Int32(postModels.count), title: title, body: body)
    }
}
