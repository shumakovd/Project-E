//
//  UserML.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import UIKit
import Foundation

struct UserML: Codable {
    let key: Int?
    let name: String?
    let birthday: Date?

    let email: String?
    let number: String?
    let password: String?
    
    let rating: Float?
    let teacher: Bool?
    
    enum CodingKeys: String, CodingKey {
        case key, name, birthday, number, email, password, rating, teacher
    }
}
