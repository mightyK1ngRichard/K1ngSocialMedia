//
//  UserAPI.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

class UserAPI: APIManager {
    static let post  = PostAPI()
    
    func getUsers(completion: @escaping (UsersDecoder?, APIError?) -> Void)  {
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
    
    func getUserById(userID: UInt, completion: @escaping (UserDecoder?, APIError?) -> Void)  {
        let urlString = "http://\(host):\(port)/users?id=\(userID)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil, .badURL)
            }
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let _ = error {
                DispatchQueue.main.async {
                    completion(nil, .NotConnect)
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
