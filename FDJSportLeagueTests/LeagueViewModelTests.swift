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
      var mockRepository: MockLeagueRepository!

      override func setUp() {
          super.setUp()
          mockRepository = MockLeagueRepository()
      }

      func testFetchLeaguesSuccess() async {
          mockRepository.leaguesToReturn = [
              League(idLeague: "1", strLeague: "Premier League", strSport: "Soccer"),
              League(idLeague: "2", strLeague: "La Liga", strSport: "Soccer")
          ]

          await MainActor.run {
              viewModel = LeagueViewModel(repository: mockRepository)
          }

          await viewModel.fetchLeagues()

          await MainActor.run {
              XCTAssertEqual(viewModel.leagues.count, 2)
              XCTAssertNil(viewModel.errorMessage)
              XCTAssertFalse(viewModel.isLoading)
          }
      }

      func testFetchLeaguesFailure() async {
          mockRepository.shouldReturnError = true

          await MainActor.run {
              viewModel = LeagueViewModel(repository: mockRepository)
          }

          await viewModel.fetchLeagues()

          await MainActor.run {
              XCTAssertEqual(viewModel.leagues.count, 0)
              XCTAssertNotNil(viewModel.errorMessage)
              XCTAssertFalse(viewModel.isLoading)
          }
      }

      func testFilteredLeagues() async {
          mockRepository.leaguesToReturn = [
              League(idLeague: "1", strLeague: "Premier League", strSport: "Soccer"),
              League(idLeague: "2", strLeague: "La Liga", strSport: "Soccer")
          ]

          await MainActor.run {
              viewModel = LeagueViewModel(repository: mockRepository)
          }

          await viewModel.fetchLeagues()

          await MainActor.run {
              viewModel.searchText = "Premier"
              let filtered = viewModel.filteredLeagues
              XCTAssertEqual(filtered.count, 1)
              XCTAssertEqual(filtered.first?.strLeague, "Premier League")
          }
      }
  }
