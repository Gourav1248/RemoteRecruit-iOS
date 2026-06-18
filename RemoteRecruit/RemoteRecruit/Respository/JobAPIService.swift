//
//  JobAPIService.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

protocol JobAPIServiceProtocol {
   func fetchJobs(count: Int) async throws -> [Job]
}

final class JobAPIService: JobAPIServiceProtocol {
   private let baseURL = "https://jobicy.com/api/v2/remote-jobs"
   private let session: URLSession

   init(session: URLSession = .shared) {
      self.session = session
   }

   func fetchJobs(count: Int = 50) async throws -> [Job] {
      guard var components = URLComponents(string: baseURL) else {
         throw URLError(.badURL)
      }
      components.queryItems = [URLQueryItem(name: "count", value: "\(count)")]

      guard let url = components.url else {
         throw URLError(.badURL)
      }

      let (data, response) = try await session.data(from: url)

      guard let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode) else {
         throw URLError(.badServerResponse)
      }

      // Job array seedha yahin decode ho raha he, DTO ki zarurat nahi
      let decoded = try JSONDecoder().decode(JobListResponse.self, from: data)
      return decoded.jobs
   }
}

// MARK: - Sirf top-level "jobs" key tak pahunchne ke liye, kahin aur use nahi hota
private struct JobListResponse: Decodable {
   let jobCount: Int
   let jobs: [Job]
}

