//
//  LeagueSearchView.swift
//  FDJSportLeague
//
//  Created by aymen braham on 03/09/2025.
//

import SwiftUI

struct LeagueSearchView: View {
    @ObservedObject var viewModel: LeagueViewModel
     
     let columns = [
         GridItem(.flexible()),
         GridItem(.flexible())
     ]
     
     var body: some View {
         NavigationView {
             Group {
                 if let league = viewModel.selectedLeague {
                     ScrollView {
                         LazyVGrid(columns: columns, spacing: 20) {
                             ForEach(viewModel.teams) { team in
                                 VStack {
                                     AsyncImage(url: URL(string: team.strBadge ?? "")) { image in
                                         image.resizable()
                                             .scaledToFit()
                                             .frame(width: 120, height: 120)
                                     } placeholder: {
                                         ProgressView()
                                     }
                                 }
                                 .frame(maxWidth: .infinity)
                             }
                         }
                         .padding()
                     }
                     
                 } else {
                     // leagues List
                     List(viewModel.filteredLeagues) { league in
                         VStack(alignment: .leading) {
                             Text(league.strLeague)
                                 .font(.headline)
                             Text(league.strSport)
                                 .font(.subheadline)
                                 .foregroundColor(.gray)
                         }
                         .onTapGesture {
                             Task {
                                  await viewModel.fetchTeams(for: league)
                              }
                         }
                     }
                 }
             }
             .searchable(
                 text: $viewModel.searchText,
                 placement: .navigationBarDrawer(displayMode: .always),
                 prompt: "Search by league"
             )
             .onChange(of: viewModel.searchText) { newValue in
                 if newValue.isEmpty {
                     viewModel.selectedLeague = nil
                     viewModel.teams = []
                 }
             }
             // Loader
             .overlay {
                 if viewModel.isLoading {
                     ProgressView("loading...")
                 }
             }
             // Error
             .overlay {
                 if let errorMessage = viewModel.errorMessage {
                     Text(errorMessage)
                         .foregroundColor(.red)
                 }
             }
         }
     }
 }
