//
//  Breed.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/26/21.
//

import Foundation

protocol BreedProtocol {
    var name: String { get }
    var subBreeds: [String] { get }
}

struct Breed: BreedProtocol {
    let name: String
    let subBreeds: [String]
}

struct BreedResource: Codable {
    private let message: [String: [String]]
    let status: String
    
    var breeds: [Breed] {
        return message.map { Breed(name: $0.key, subBreeds: $0.value) }
    }
    
    enum CodingKeys: CodingKey {
        case message
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode([String: [String]].self, forKey: .message)
        status = try container.decode(String.self, forKey: .status)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(status, forKey: .status)
    }
}

struct Test_Breed: BreedProtocol {
    let name: String
    let subBreeds: [String]

    init(name: String, subBreeds: [String]) {
        self.name = name
        self.subBreeds = subBreeds
    }
}
