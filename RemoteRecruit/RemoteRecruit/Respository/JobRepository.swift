//
//  JobRepository.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

protocol JobRepositoryProtocol {
   func fetchJobs(count: Int) async throws -> [Job]
}

final class JobRepository: JobRepositoryProtocol {
   private let apiService: JobAPIServiceProtocol

   init(apiService: JobAPIServiceProtocol = JobAPIService()) {
      self.apiService = apiService
   }

   func fetchJobs(count: Int = 50) async throws -> [Job] {
      try await apiService.fetchJobs(count: count)
   }
}

