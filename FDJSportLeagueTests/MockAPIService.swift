//
//  MockAPIService.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    var leaguesToReturn: [League] = []
    var teamsToReturn: [Team] = []
    var shouldReturnError = false
    
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1)))
        } else {
            completion(.success(leaguesToReturn))
        }
    }
    
    func fetchTeams(for leagueName: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1)))
        } else {
            completion(.success(teamsToReturn))
        }
    }
}
