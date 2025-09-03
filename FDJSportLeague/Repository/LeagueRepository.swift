//
//  LeagueRepository.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

protocol LeagueRepositoryProtocol {
    func getLeagues() async throws -> [League]
    func getTeams(for leagueName: String) async throws -> [Team]
}

class LeagueRepository: LeagueRepositoryProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getLeagues() async throws -> [League] {
        return try await apiService.fetchLeagues()
    }
    
    func getTeams(for leagueName: String) async throws -> [Team] {
        let teams = try await apiService.fetchTeams(for: leagueName)
        return teams.sorted { $0.strTeam > $1.strTeam }
            .enumerated()
            .compactMap { index, team in index % 2 == 0 ? team : nil }
    }
}
