//
//  APIService.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void)
    func fetchTeams(for leagueName: String, completion: @escaping (Result<[Team], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://www.thesportsdb.com/api/v1/json/123/"
    
    // MARK: - API Leagues
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void) {
        let url = URL(string: baseURL + "all_leagues.php")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(LeagueResponse.self, from: data)
                completion(.success(decoded.leagues))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - API Teams
    func fetchTeams(for leagueName: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        let encodedName = leagueName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? leagueName
        let url = URL(string: baseURL + "search_all_teams.php?l=\(encodedName)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(TeamResponse.self, from: data)
                completion(.success(decoded.teams))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
