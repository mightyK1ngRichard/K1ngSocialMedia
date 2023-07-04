//
//  TestPostRequest.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 02.07.2023.
//

import SwiftUI

struct TestPostRequest: View {
    var body: some View {
        VStack {
            Button("press") {
                APIPostManager.shared.PushName()
            }
        }
    }
}

struct TestPostRequest_Previews: PreviewProvider {
    static var previews: some View {
        TestPostRequest()
    }
}

private class APIPostManager {
    static let shared = APIPostManager()
    
    func PushName() {
        let urlString = "http://localhost:8010/test"
        guard let url = URL(string: urlString) else { print("Bad url"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let message = ["name": "kingJSONIos"]
        do {
            let httpBody = try JSONEncoder().encode(message)
            request.httpBody = httpBody
            
        } catch {
            print("error from encoding: ", error)
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error from urlsession: \(error)")
                return
            }
            guard let data = data else { print("Data is nil"); return }
            
            if let user = try? JSONDecoder().decode(PostNameDecoder.self, from: data) {
                print(user.name)

            } else {
                print("error from data")
            }
    
            
        }.resume()
    }
    
    func PushName2() {
        let urlString = "http://localhost:8010/test"
        guard let url = URL(string: urlString) else { print("Bad url"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let message = "DimaFromIosApp"
        let bodyString = "name=\(message)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let bodyString = bodyString else { print("error of addingPercentEncoding"); return }
        let httpBody = bodyString.data(using: .utf8)
        print("HTTPBODY: \(bodyString)")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error from urlsession: \(error)")
                return
            }
            guard let data = data else { print("Data is nil"); return }
            
            if let user = try? JSONDecoder().decode(PostNameDecoder.self, from: data) {
                print(user.name)
            } else {
                print("error from data")
            }
    
            
        }.resume()
    }
}

private class PostNameDecoder: Decodable {
    let name: String
}
