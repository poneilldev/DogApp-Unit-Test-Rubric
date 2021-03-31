//
//  Test_DogDetailsViewController.swift
//  Dog-appTests
//
//  Created by Paul O'Neill on 3/31/21.
//

import XCTest
@testable import Dog_app

class Test_DogDetailsViewController: XCTestCase {
    var sut: DogDetailsViewController!
    override func setUpWithError() throws {
        sut = DogDetailsViewController(breed: Test_Breed())
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadView() {
        XCTAssertEqual(sut.view, sut.contentView)
    }
    
    func testVCTitle() {
        let breed = Test_Breed(name: "Golden Retreiver", subBreeds: [])
        sut = DogDetailsViewController(breed: breed)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, breed.name)
    }
    
    func testDidSelectBreed() {
        let testBreed = Test_Breed(name: "Test Dog", subBreeds: ["Poodle", "Golden Retreiver", "Hound"])
        sut = DogDetailsViewController(breed: testBreed)
        let navigationController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        
        let selectedIndex = 0
        
        sut.tableView(sut.contentView.subBreedsTableView, didSelectRowAt: IndexPath(row: selectedIndex, section: 0))
        let expectation = XCTestExpectation(description: "Selecting a table view cell.")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        guard let detail = navigationController.topViewController as? DogDetailsViewController else {
            XCTFail("Didn't push to DogDetailsViewController")
            return
        }
        
        detail.loadViewIfNeeded()
        
        XCTAssertEqual(detail.title, testBreed.subBreeds[selectedIndex])
    }
    
    func testNumberOfRows() {
        let testBreed = Test_Breed(name: "Test Dog", subBreeds: ["Poodle", "Golden Retreiver", "Hound"])
        sut = DogDetailsViewController(breed: testBreed)
        sut.loadViewIfNeeded()
        
        let numberOfRows = sut.tableView(sut.contentView.subBreedsTableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, testBreed.subBreeds.count)
    }
    
    func testCellForRowAtIndexPath() {
        let testBreed = Test_Breed(name: "Test Dog", subBreeds: ["Poodle", "Golden Retreiver", "Hound"])
        sut = DogDetailsViewController(breed: testBreed)
        sut.loadViewIfNeeded()
        
        let indexOfFocus = 0
        
        let cell = sut.tableView(sut.contentView.subBreedsTableView, cellForRowAt: IndexPath(row: indexOfFocus, section: 0)) as! FindDogTableViewCell
        
        XCTAssertEqual(cell.breedNameLabel.text, testBreed.subBreeds[indexOfFocus])
    }
}
