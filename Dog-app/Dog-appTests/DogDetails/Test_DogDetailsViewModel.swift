//
//  Test_DogDetailsViewModel.swift
//  Dog-appTests
//
//  Created by Paul O'Neill on 3/30/21.
//

import XCTest
@testable import Dog_app

class Test_DogDetailsViewModel: XCTestCase {
    var sut: DogDetailsViewModel!
    
    override func setUpWithError() throws {
        sut = DogDetailsViewModel(Test_Breed())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSubBreedsCount_empty() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: [])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertTrue(sut.subBreeds.isEmpty)
    }
    
    func testSubBreedsCount_hasOne() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: ["SubBreed"])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertFalse(sut.subBreeds.isEmpty)
        XCTAssertEqual(sut.subBreeds.count, 1)
    }
    
    func testSubBreedsCount_hasThree() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: ["SubBreed", "SubBreed", "SubBreed"])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertFalse(sut.subBreeds.isEmpty)
        XCTAssertEqual(sut.subBreeds.count, 3)
    }
    
    func testInit_nameEquals() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: ["SubBreed", "SubBreed", "SubBreed"])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertEqual(sut.breed.name, "Hound")
    }
    
    func testSubBreed_noSubreeds() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: [])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertNil(sut.getSubBreed(at: IndexPath(row: 0, section: 0)))
    }
    
    func testSubBreed_negativeIndex() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: ["SubBreed", "SubBreed", "SubBreed"])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertNil(sut.getSubBreed(at: IndexPath(row: -1, section: 0)))
    }

    func testSubBreed_firstIndex() {
        let testBreed = Test_Breed(name: "Hound", subBreeds: ["SubBreed", "SubBreed", "SubBreed"])
        sut = DogDetailsViewModel(testBreed)
        
        XCTAssertNotNil(sut.getSubBreed(at: IndexPath(row: 0, section: 0)))
    }
}
