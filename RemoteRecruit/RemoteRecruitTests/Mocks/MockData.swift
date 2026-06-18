//
//  MockData.swift
//  RemoteRecruitTests
//
//  Created by Gourav Joshi on 18/06/26.
//

import XCTest
@testable import RemoteRecruit

enum MockData {

   static let jobs: [Job] = [

      Job(
         id: 1, url: "www.apple.com",
         jobTitle: "Senior iOS Developer",
         companyName: "Apple",
         companyLogo: "",
         jobIndustry: [],
         jobType: [],
         jobGeo: "USA",
         jobLevel: "Senior",
         jobExcerpt: "",
         jobDescription: "Description",
         pubDate: "",
         salaryMin: 100000,
         salaryMax: 150000,
         salaryCurrency: "USD",
         salaryPeriod: "yearly"
      ),

      Job(
         id: 2, url: "www.google.com",
         jobTitle: "Android Developer",
         companyName: "Google",
         companyLogo: "",
         jobIndustry: [],
         jobType: [],
         jobGeo: "India",
         jobLevel: "Mid",
         jobExcerpt: "",
         jobDescription: "Description",
         pubDate: "",
         salaryMin: 90000,
         salaryMax: 120000,
         salaryCurrency: "USD",
         salaryPeriod: "yearly"
      )
   ]
}
