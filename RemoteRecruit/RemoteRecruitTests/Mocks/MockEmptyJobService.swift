//
//  File.swift
//  RemoteRecruitTests
//
//  Created by Gourav Joshi on 18/06/26.
//
@testable import RemoteRecruit

final class MockEmptyJobService: JobRepositoryProtocol {
   func fetchJobs(count: Int) async throws -> [RemoteRecruit.Job] {
      []
   }
}
