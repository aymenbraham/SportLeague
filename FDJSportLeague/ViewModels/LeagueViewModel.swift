//
//  LeagueViewModel.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

class LeagueViewModel: ObservableObject {
    @Published var leagues: [League] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedLeague: League? = nil
    @Published var teams: [Team] = []
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        fetchLeagues()
    }
    
    // MARK: Charger toutes les leagues
    func fetchLeagues() {
        isLoading = true
        errorMessage = nil
        
        apiService.fetchLeagues { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let leagues):
                    self?.leagues = leagues
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: Filtrage 
    var filteredLeagues: [League] {
        if searchText.isEmpty {
            return []
        } else {
            return leagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // MARK: Charger toutes les équipes
    func fetchTeams(for league: League) {
        isLoading = true
        errorMessage = nil
        selectedLeague = league
        searchText = league.strLeague
        
        apiService.fetchTeams(for: league.strLeague) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let teams):
                    var sorted = teams.sorted { $0.strTeam > $1.strTeam }
                    sorted = sorted.enumerated().compactMap { index, team in
                        return index % 2 == 0 ? team : nil
                    }
                    self?.teams = sorted
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
