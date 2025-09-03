//
//  TeamModel.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

struct TeamResponse: Codable {
    let teams: [Team]
}

struct Team: Codable, Identifiable {
    var id: String { idTeam }
    let idTeam: String
    let strTeam: String
    let strTeamAlternate: String?
    let strLeague: String
    let idLeague: String
    let strStadium: String?
    let strBadge: String?
}
