//
//  PostAPI.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

class PostAPI: APIManager {
    func getUserPost(userID: UInt, completion: @escaping (PostDecoder?, APIError?) -> Void)  {
        let urlString = "http://\(host):\(port)/posts?user_id=\(userID)"
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
                    
                    if let posts = try? JSONDecoder().decode(PostDecoder.self, from: data) {
                        DispatchQueue.main.async {
                            completion(posts, nil)
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
    
    func getAllCommentsByUserID(userID: UInt, completion: @escaping (PostDecoder?, APIError?) -> Void)  {
        let urlString = "http://\(host):\(port)/comments?user_id=\(userID)"
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
                    
                    if let posts = try? JSONDecoder().decode(PostDecoder.self, from: data) {
                        DispatchQueue.main.async {
                            completion(posts, nil)
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
