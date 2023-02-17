//
//  PostModel.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Foundation

struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
