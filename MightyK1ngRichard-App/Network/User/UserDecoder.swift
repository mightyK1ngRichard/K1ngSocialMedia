//
//  UserDecoder.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

class UsersDecoder: Decodable {
    let users: [UserRow]
}

class UserDecoder: Decodable, Identifiable {
    let user: UserRow
}

class UserRow: Decodable, Identifiable {
    let id               : UInt
    let nickname         : String
    let description      : String?
    let location         : String?
    let university       : String?
    let header_image     : URL?
    let avatar           : URL?
    let count_of_friends : Int
    let posts            : [PostRow]?
    let images           : [ImageRow]?
}

class ImageRow: Decodable, Identifiable {
    let id                : UInt
    let date_public       : String
    let image_name        : URL
    let count_of_likes    : Int
    let count_of_comments : Int
    let user_id           : Int
}
