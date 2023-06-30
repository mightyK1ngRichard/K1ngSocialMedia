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
    let avatar            : URL?
    let nickname          : String
    let files             : [PostFilesDecoder]?
}

class PostFilesDecoder: Decodable, Identifiable {
    let id        : UInt
    let file_name : URL?
    let post_id   : Int
}

/// Хах, прикольная штучка.
/*
 enum CodingKeys: String, CodingKey {
     case id
     case datePublic = "date_public"
     case content
     case count_of_likes
     case count_of_comments
     case user_id
     case avatar
     case nickname
 }

 required init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(UInt.self, forKey: .id)
     content = try container.decode(String.self, forKey: .content)
     count_of_likes = try container.decode(Int.self, forKey: .count_of_likes)
     count_of_comments = try container.decode(Int.self, forKey: .count_of_comments)
     user_id = try container.decode(Int.self, forKey: .user_id)
     avatar = try container.decodeIfPresent(URL.self, forKey: .avatar)
     nickname = try container.decode(String.self, forKey: .nickname)

     let dateString = try container.decode(String.self, forKey: .datePublic)
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
     dateFormatter.locale = Locale(identifier: "en_US_POSIX")
     dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

     guard let date = dateFormatter.date(from: dateString) else {
         throw DecodingError.dataCorruptedError(forKey: .datePublic, in: container, debugDescription: "Invalid date format")
     }

     date_public = date
 }
 */
