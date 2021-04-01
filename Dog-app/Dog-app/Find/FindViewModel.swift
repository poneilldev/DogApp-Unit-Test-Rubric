//
//  FindViewModel.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/29/21.
//

import Foundation
import Combine

enum NetworkError: LocalizedError {
    case invalidResponse
    case badResponse(statusCode: Int)
}

class FindDogViewModel {
    private let allBreeds = CurrentValueSubject<[BreedProtocol]?, Never>(nil)
    var viewState = CurrentValueSubject<ViewState<BreedProtocol>, Never>(.loading)
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllBreeds()
    }
    
    init(breeds: [BreedProtocol]) {
        self.allBreeds.value = breeds
    }
    
    func getBreed(at index: IndexPath) -> BreedProtocol? {
        guard let breeds = allBreeds.value, !breeds.isEmpty else { return nil }
        guard index.row < breeds.count && index.row >= 0 else { return nil }
        return breeds[index.row]
    }
    
    func getBreedCount() -> Int {
        return allBreeds.value?.count ?? 0
    }
    
    func getAllBreeds() {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        viewState.send(.loading)
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
                guard httpResponse.statusCode == 200 else {
                    throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
                }
                return data
            }
            .decode(type: BreedResource.self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.viewState.send(.error(error))
                case .finished:
                    print("SUCCESS!")
                }
            } receiveValue: { [weak self] resource in
                self?.allBreeds.send(resource.breeds)
                self?.viewState.send(.results(resource.breeds))
            }.store(in: &cancellables)

    }
}
