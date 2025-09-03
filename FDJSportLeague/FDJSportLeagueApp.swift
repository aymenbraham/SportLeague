//
//  FDJSportLeagueApp.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import SwiftUI

@main
struct FDJSportLeagueApp: App {
    var body: some Scene {
        WindowGroup {
            LeagueSearchView(viewModel: LeagueViewModel())
        }
    }
}
