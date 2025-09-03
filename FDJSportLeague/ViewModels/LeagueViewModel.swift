//
//  LeagueViewModel.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

import Foundation

@MainActor
class LeagueViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var leagues: [League] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedLeague: League? = nil
    @Published var teams: [Team] = []

    // MARK: - Dependencies
    private let repository: LeagueRepositoryProtocol

    // MARK: - Init
    init(repository: LeagueRepositoryProtocol = LeagueRepository()) {
        self.repository = repository
        Task { await fetchLeagues() }
    }

    // MARK: - Fetch all leagues
    func fetchLeagues() async {
        isLoading = true
        errorMessage = nil
        do {
            let leagues = try await repository.getLeagues()
            self.leagues = leagues
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    // MARK: - Fetch teams for a league
    func fetchTeams(for league: League) async {
        isLoading = true
        errorMessage = nil
        selectedLeague = league
        searchText = league.strLeague
        do {
            let teams = try await repository.getTeams(for: league.strLeague)
            self.teams = teams
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    // MARK: - Filtered leagues for search
    var filteredLeagues: [League] {
        if searchText.isEmpty { return [] }
        return leagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText) }
    }
}
