//
//  MockFailureJobService.swift
//  RemoteRecruitTests
//
//  Created by Gourav Joshi on 18/06/26.
//

@testable import RemoteRecruit

enum MockError: Error {
   case invalidResponse
}

final class MockFailureJobService: JobRepositoryProtocol {
   func fetchJobs(count: Int) async throws -> [RemoteRecruit.Job] {
      throw MockError.invalidResponse
   }
}
