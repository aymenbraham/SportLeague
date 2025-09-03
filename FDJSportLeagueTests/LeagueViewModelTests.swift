//
//  LeagueViewModelTests.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import XCTest
@testable import FDJSportLeague

final class LeagueViewModelTests: XCTestCase {
    var viewModel: LeagueViewModel!
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }

    func testFetchLeaguesSuccess() {
        mockService.leaguesToReturn = [
            League(idLeague: "1", strLeague: "Premier League", strSport: "Soccer"),
            League(idLeague: "2", strLeague: "La Liga", strSport: "Soccer")
        ]
        
        viewModel = LeagueViewModel(apiService: mockService)
        
        let expectation = XCTestExpectation(description: "fetch leagues")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.leagues.count, 2)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchLeaguesFailure() {
        mockService.shouldReturnError = true
        viewModel = LeagueViewModel(apiService: mockService)
        
        let expectation = XCTestExpectation(description: "fetch leagues error")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.leagues.count, 0)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilteredLeagues() {
        mockService.leaguesToReturn = [
            League(idLeague: "1", strLeague: "Premier League", strSport: "Soccer"),
            League(idLeague: "2", strLeague: "La Liga", strSport: "Soccer")
        ]
        viewModel = LeagueViewModel(apiService: mockService)
        
        viewModel.searchText = "Premier"
        
        let expectation = XCTestExpectation(description: "filter leagues")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.filteredLeagues.count, 1)
            XCTAssertEqual(self.viewModel.filteredLeagues.first?.strLeague, "Premier League")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
