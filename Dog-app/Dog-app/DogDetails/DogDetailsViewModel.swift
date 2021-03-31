//
//  DogDetailsViewModel.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import Foundation
import UIKit
import Combine

class DogDetailsViewModel {
    var cancellables = Set<AnyCancellable>()
    let breed: BreedProtocol
    let viewState = CurrentValueSubject<ViewState<BreedProtocol>, Never>(.loading)
    let randomImageUrl = PassthroughSubject<URL, Never>()
    
    
    var subBreeds: [BreedProtocol] {
        breed.subBreeds.map { Breed(name: $0, subBreeds: []) }
    }
    
    init(_ breed: BreedProtocol) {
        self.breed = breed
        loadRandomBreedImage()
    }
    
    func getSubBreed(at indexPath: IndexPath) -> BreedProtocol? {
        guard indexPath.row < subBreeds.count, indexPath.row >= 0 else { return nil }
        return subBreeds[indexPath.row]
    }
    
    func loadRandomBreedImage() {
        guard let url = URL(string: "https://dog.ceo/api/breed/\(breed.name)/images/random") else { return }
        viewState.send(.loading)
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: BreedImage.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [viewState, breed] result in
                switch result {
                case .failure(let error):
                    viewState.send(.error(error))
                    print(error.localizedDescription)
                case .finished:
                    viewState.send(.oneResult(breed))
                }
            } receiveValue: { [randomImageUrl] imgUrl in
                if let url = URL(string: imgUrl.message) {
                    randomImageUrl.send(url)
                } else {
                    print("COULD NOT FIND URL STRING: \(imgUrl.message)")
                }
            }.store(in: &cancellables)
    }
    
    func createAppointment() {
        print("CREATING APPOINTMENT FOR BREED: \(breed.name)!")
    }
}
