//
//  MockJobService.swift
//  RemoteRecruitTests
//
//  Created by Gourav Joshi on 18/06/26.
//

import XCTest
@testable import RemoteRecruit

final class MockJobService: JobRepositoryProtocol {


   func fetchJobs(count: Int = 50) async throws -> [Job] {
      MockData.jobs
   }
}
