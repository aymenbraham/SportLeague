//
//  MockLeagueRepository.swift
//  FDJSportLeagueTests
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation
@testable import FDJSportLeague

class MockLeagueRepository: LeagueRepositoryProtocol {
    var leaguesToReturn: [League] = []
    var teamsToReturn: [Team] = []
    var shouldReturnError = false

    func getLeagues() async throws -> [League] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1)
        } else {
            return leaguesToReturn
        }
    }

    func getTeams(for leagueName: String) async throws -> [Team] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1)
        } else {
            return teamsToReturn
        }
    }
}

