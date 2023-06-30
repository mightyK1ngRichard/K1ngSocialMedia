//
//  APIManager.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import Foundation

/// Работа с go lang server.
class APIManager {
    static var shared = APIManager()
    private let host  = "localhost"
    private let port  = 8010
    
    func getUsers(completion: @escaping (UsersDecoder?, APIError?) -> Void) {
        let urlString = "http://\(host):\(port)/users"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil, .badURL)
            }
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(nil, err as? APIError)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                // TODO: add status codes of 201 202 203 ...
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(nil, .dataIsNil)
                        }
                        return
                    }
                    
                    if let users = try? JSONDecoder().decode(UsersDecoder.self, from: data) {
                        DispatchQueue.main.async {
                            completion(users, nil)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            completion(nil, .decodedError)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .noResponse)
                }
            }

        }.resume()
    }
    
    func getUserById(userID: Int, completion: @escaping (UserDecoder?, APIError?) -> Void) {
        let urlString = "http://\(host):\(port)/users?id=\(userID)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil, .badURL)
            }
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(nil, err as? APIError)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                // TODO: add status codes of 201 202 203 ...
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(nil, .dataIsNil)
                        }
                        return
                    }
                    
                    if let user = try? JSONDecoder().decode(UserDecoder.self, from: data) {
                        DispatchQueue.main.async {
                            completion(user, nil)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            completion(nil, .decodedError)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .noResponse)
                }
            }

        }.resume()
    }
}
