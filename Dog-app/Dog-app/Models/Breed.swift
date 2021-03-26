//
//  Breed.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/26/21.
//

import Foundation

class Breed: BreedProtocol, Codable {
    let name: String
    let subBreeds: [BreedProtocol]
}

protocol BreedProtocol {
    var name: String { get }
    var subBreeds: [BreedProtocol] { get }
}

struct Test_Breed: BreedProtocol {
    let name: String
    let subBreeds: [BreedProtocol]

    init(name: String, subBreeds: [BreedProtocol]) {
        self.name = name
        self.subBreeds = subBreeds
    }
}
