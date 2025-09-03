//
//  APIService.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchLeagues() async throws -> [League]
    func fetchTeams(for leagueName: String) async throws -> [Team]
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://www.thesportsdb.com/api/v1/json/123/"
    
    // MARK: - API Leagues
    func fetchLeagues() async throws -> [League] {
            let url = URL(string: baseURL + "all_leagues.php")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(LeagueResponse.self, from: data)
            return decoded.leagues
        }
    
    // MARK: - API Teams
    func fetchTeams(for leagueName: String) async throws -> [Team] {
        let encodedName = leagueName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? leagueName
        let url = URL(string: baseURL + "search_all_teams.php?l=\(encodedName)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(TeamResponse.self, from: data)
        return decoded.teams
    }
}
