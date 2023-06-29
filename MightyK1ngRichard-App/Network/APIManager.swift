//
//  APIManager.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import Foundation

class UserDecoder: Decodable {
    let users: [UserRow]
}

class UserRow: Decodable, Identifiable {
    let id: Int
    let nickname: String
    let description: String?
    let location: String?
    let university: String?
    let header_image: URL?
    let avatar: URL?
    let count_of_friends: Int
}


/// Работа с go lang server.
class APIManager {
    static var shared = APIManager()
    let host = "localhost"
    let port = 8010
    
    func getUsers(completion: @escaping (UserDecoder?, String?) -> Void) {
        let urlString = "http://\(host):\(port)/users"
        guard let url = URL(string: urlString) else {
            completion(nil, "ERROR: bad url")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print("RESPOND: ", response ?? "response is nil")
//            print("ERROR: ", error ?? "error is nil")
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, "ERROR: data is nil")
                }
                return
            }
            if let users = try? JSONDecoder().decode(UserDecoder.self, from: data) {
                DispatchQueue.main.async {
                    completion(users, nil)
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(nil, "ERROR: decoded error")
                }
            }
            
        }.resume()
    }
 
}
