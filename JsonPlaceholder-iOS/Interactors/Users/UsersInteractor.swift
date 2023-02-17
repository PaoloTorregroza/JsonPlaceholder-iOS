//
//  UserInteractor.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation
import Combine
import Alamofire

class UsersInteractor {
    private let localData: DataLayer
    private var cancellables = Set<AnyCancellable>()
    @Published var userModels: [UserModel] = []
    
    init(model: DataLayer) {
        self.localData = model
        setup()
    }
    
    private func setup() {
        self.localData.$users
            .map({ users -> [UserModel] in
                return users.map({
                    UserModel(id: Int($0.id), phone: $0.phone!, name: $0.name!, email: $0.email!)
                })
            })
            .replaceError(with: [])
            .assign(to: \.userModels, on: self)
            .store(in: &cancellables)
        
        if userModels.count == 0 {
            loadRemote()
        }
    }
    
    private func loadRemote() {
        let req = AF.request("https://jsonplaceholder.typicode.com/users", encoding: JSONEncoding.default)
        
        req.responseDecodable(of: Array<UserModel>.self) { response in
            switch response.result {
            case .failure:
                print("Error loading users")
            case .success:
                guard let data = response.value else { return }
                self.userModels = data
                
                for user in data {
                    self.addNewUser(id: user.id, name: user.name, email: user.email, phone: user.phone)
                }
            }
        }
    }
    
    func addNewUser(id: Int, name: String, email: String, phone: String) {
        localData.addNewuser(
            id: Int32(id),
            name: name,
            email: email,
            phone: phone
        )
    }
    
    func deleteUser(_ index: IndexSet) {
        var usersCopy = userModels
        usersCopy.move(fromOffsets: index, toOffset: 0)
        
        if let userToDelete = localData.users.filter({usersCopy.first!.id == $0.id}).first {
            localData.deleteUser(userToDelete)
        }
    }
}
