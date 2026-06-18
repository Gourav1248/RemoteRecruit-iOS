//
//  JobListViewModelTests.swift
//  RemoteRecruitTests
//
//  Created by Gourav Joshi on 18/06/26.
//

import XCTest
@testable import RemoteRecruit

@MainActor
final class JobListViewModelTests: XCTestCase {

   private var sut: JobListViewModel!
   private var mockRepository: MockJobService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       mockRepository = MockJobService()
       sut = JobListViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
       sut = nil
       mockRepository = nil

    }

   //Success case
   func test_fetchJobs_shouldPopulateJobs() async {

      //Here ACT
      await sut.fetchJobs()

      XCTAssertEqual(sut.jobs.count, 2)
      XCTAssertNil(sut.errorMessage)
      XCTAssertFalse(sut.isLoading)
   }

   //Empty case
   func test_fetchJobs_WithEmptyResponse_shouldReturnEmptyArray() async {

      sut = JobListViewModel(repository: MockEmptyJobService())

      await sut.fetchJobs()

      XCTAssertTrue(sut.jobs.isEmpty)
      XCTAssertNil(sut.errorMessage)

   }

   //Failure case
   func test_fetchJobs_WhenRepositoryFails_shouldSetErrorMessage() async {

      sut = JobListViewModel(repository: MockFailureJobService())

      await sut.fetchJobs()

      XCTAssertTrue(sut.jobs.isEmpty)
      XCTAssertNotNil(sut.errorMessage)
   }

   //Search cases: search by title
   func test_searchByTitle_shouldReturnMatchingJobs() async {

      //Arrange: managing the case calling function
      await sut.fetchJobs()

      //Act
      sut.searchText = "ios"

      //Assert
      XCTAssertEqual(sut.filteredJobs.count, 1)

   }

   //Search cases: search by title
   func test_searchByCompany_shouldReturnMatchingJobs() async {

      await sut.fetchJobs()

      sut.searchText = "google"

      XCTAssertEqual(sut.filteredJobs.count, 1)
   }

   //Search cases: Empty search
   func test_emptySearch_shouldReturnAllJobs() async {

      await sut.fetchJobs()

      sut.searchText = ""

      XCTAssertEqual(sut.filteredJobs.count, sut.jobs.count)
   }

   //loading case
   func test_fetchJobs_shouldStopLoadingAfterCompletion() async {

      await sut.fetchJobs()

      XCTAssertFalse(sut.isLoading)
   }
}
