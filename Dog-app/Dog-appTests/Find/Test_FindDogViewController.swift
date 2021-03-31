//
//  Test_FindDogViewController.swift
//  Dog-appTests
//
//  Created by Paul O'Neill on 3/30/21.
//

import XCTest
@testable import Dog_app

class Test_FindDogViewController: XCTestCase {
    var sut: FindDogViewController!
    var viewModel: FindDogViewModel!
    override func setUpWithError() throws {
        viewModel = FindDogViewModel()
        sut = FindDogViewController(viewModel: viewModel)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(sut.isViewLoaded)
    }
    
    func testLoadView() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.view, sut.contentView)
    }
    
    func testViewState_loading() {
        viewModel.viewState.send(.loading)
        
        let expectation = XCTestExpectation(description: "Checking for loading.")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(sut.contentView.loadingIndicator.isAnimating)
    }
    
    func testViewState_error() {
        viewModel.viewState.send(.error(NetworkError.invalidResponse))
        
        let expectation = XCTestExpectation(description: "Checking for loading.")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(sut.contentView.loadingIndicator.isAnimating)
    }
    
    func testViewState_noAuth() {
        viewModel.viewState.send(.noAuth)
        let expectation = XCTestExpectation(description: "Checking for loading.")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(sut.contentView.loadingIndicator.isAnimating)
    }

    func testViewState_results() {
        viewModel.viewState.send(.oneResult(Test_Breed(name: "dog", subBreeds: [])))
        let expectation = XCTestExpectation(description: "Checking for loading.")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(sut.contentView.loadingIndicator.isAnimating)
    }
}
