//
//  Test_FindDogViewModel.swift
//  Dog-appTests
//
//  Created by Paul O'Neill on 3/30/21.
//

import XCTest
@testable import Dog_app

class Test_FindDogViewModel: XCTestCase {
    var sut: FindDogViewModel!
    override func setUpWithError() throws {
        sut = FindDogViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetBreed_notNil() {
        let testBreeds = [Test_Breed(), Test_Breed(), Test_Breed()]
        sut = FindDogViewModel(breeds: testBreeds)
        
        let breed = sut.getBreed(at: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(breed)
    }
    
    func testGetBreed_isNil() {
        let testBreeds = [Test_Breed(), Test_Breed(), Test_Breed()]
        sut = FindDogViewModel(breeds: testBreeds)
        
        let breed = sut.getBreed(at: IndexPath(row: 4, section: 0))
        
        XCTAssertNil(breed)
    }
    
    func testGetBreed_empty_isNil() {
        sut = FindDogViewModel()
        
        let breed = sut.getBreed(at: IndexPath(row: 0, section: 0))
        
        XCTAssertNil(breed)
    }
    
    func testGetBreed_badIndex() {
        let testBreeds = [Test_Breed(), Test_Breed(), Test_Breed()]
        sut = FindDogViewModel(breeds: testBreeds)
        
        let breed = sut.getBreed(at: IndexPath(row: -1, section: 0))
        
        XCTAssertNil(breed)
    }
    
    func testGetBreed_correctIndex() {
        let testBreeds = [Test_Breed(name: "Hound", subBreeds: []),
                          Test_Breed(name: "Golden Retriever", subBreeds: []),
                          Test_Breed(name: "Poodle", subBreeds: [])]
        sut = FindDogViewModel(breeds: testBreeds)
        
        let breed = sut.getBreed(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(breed?.name, "Poodle")
    }
    
    func testGetAllBreeds() {
        let testBreeds = [Test_Breed(name: "Hound", subBreeds: []),
                          Test_Breed(name: "Golden Retriever", subBreeds: []),
                          Test_Breed(name: "Poodle", subBreeds: [])]
        sut = FindDogViewModel(breeds: testBreeds)
        
        let count = sut.getBreedCount()
        
        XCTAssertEqual(count, 3)
    }
}
