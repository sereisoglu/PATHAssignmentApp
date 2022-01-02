//
//  MarvelAPITests.swift
//  MarvelAPITests
//
//  Created by Saffet Emin Reisoğlu on 2.01.2022.
//

import XCTest
@testable import MarvelAPI

class MarvelAPITests: XCTestCase {

    func test_Characters_Success() {
        let expectation = expectation(description: #function)
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: nil),
            page: 1
        ) { (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Characters_Search_Success() {
        let expectation = expectation(description: #function)
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: "iron man"),
            page: 1
        ) { (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Character_Comics_Success() {
        let expectation = expectation(description: #function)
        
        MarvelAPI.shared.request(
            endpoint: .characterComics(
                id: 1009368,
                lastDate: "2022-01-02"
            )
        ) { (result: Result<ResultsModel<ComicModel>?, ErrorModel>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
