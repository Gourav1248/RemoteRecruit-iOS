//
//  JobListViewModel.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

@MainActor
final class JobListViewModel: ObservableObject {
   @Published var jobs: [Job] = []
   @Published var isLoading = false
   @Published var errorMessage: String?
   @Published var searchText: String = ""
   @Published private(set) var isConnected = true

   private let repository: JobRepositoryProtocol
   private let networkMonitor: NetworkMonitor

   init(
      repository: JobRepositoryProtocol = JobRepository(),
      networkMonitor: NetworkMonitor = .shared
   ) {
      self.repository = repository
      self.networkMonitor = networkMonitor

      networkMonitor.$isConnected
         .receive(on: DispatchQueue.main)
         .assign(to: &$isConnected)
   }

   // Search ke liye filtered list - Title ya Company name se match karega
   var filteredJobs: [Job] {
      guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
         return jobs
      }
      return jobs.filter {
         $0.jobTitle.localizedCaseInsensitiveContains(searchText) ||
         $0.companyName.localizedCaseInsensitiveContains(searchText)
      }
   }

   func fetchJobs() async {
      guard isConnected else {
         errorMessage = "No internet connection. Please check your network and try again."
         return
      }

      isLoading = true
      errorMessage = nil

      do {
         jobs = try await repository.fetchJobs(count: 30)
      } catch let urlError as URLError {
         errorMessage = friendlyMessage(for: urlError)
      } catch {
         errorMessage = error.localizedDescription
      }

      isLoading = false
   }

   private func friendlyMessage(for error: URLError) -> String {
      switch error.code {
         case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
            return "No internet connection. Please check your network and try again."
         case .timedOut:
            return "Request timed out. Please try again."
         case .cannotFindHost, .cannotConnectToHost:
            return "Unable to reach the server. Please try again later."
         default:
            return "Something went wrong. Please try again."
      }
   }
}
