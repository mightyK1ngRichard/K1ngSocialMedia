//
//  PostDecoder.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

class PostDecoder: Decodable {
    let posts: [PostRow]
}

class PostRow: Decodable, Identifiable {
    let id                : UInt
    let date_public       : String
    let content           : String
    let count_of_likes    : Int
    let count_of_comments : Int
    let user_id           : Int
}
