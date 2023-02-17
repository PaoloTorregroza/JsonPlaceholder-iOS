//
//  UserModel.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let phone: String
    let name: String
    let email: String
}
