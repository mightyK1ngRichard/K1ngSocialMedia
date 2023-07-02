//
//  ErrorNetwork.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 30.06.2023.
//

import Foundation

enum APIError: Error {
    case dataIsNil
    case badURL
    case decodedError
    case noResponse
    case NotConnect
    
    func contentError() -> String {
        switch(self) {
        case .dataIsNil:
            return "Data is nil"
        case .badURL:
            return "Bad URL"
        case .decodedError:
            return "Error of decoding"
        case .noResponse:
            return "api manager without response"
        case .NotConnect:
            return "could not connect to the server"
        }
    }
}
