//
//  LeagueModel.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import Foundation

struct LeagueResponse: Codable {
    let leagues: [League]
}

struct League: Codable, Identifiable {
    var id: String { idLeague }
    let idLeague: String
    let strLeague: String
    let strSport: String
}
