//
//  Job.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

struct Job: Identifiable, Decodable {
   let id: Int
   let url: String
   let jobTitle: String
   let companyName: String
   let companyLogo: String
   let jobIndustry: [String]
   let jobType: [String]
   let jobGeo: String
   let jobLevel: String
   let jobExcerpt: String
   let jobDescription: String
   let pubDate: String
   let salaryMin: Int?
   let salaryMax: Int?
   let salaryCurrency: String?
   let salaryPeriod: String?

   enum CodingKeys: String, CodingKey {
      case id, url, jobTitle, companyName, companyLogo
      case jobIndustry, jobType, jobGeo, jobLevel, jobExcerpt, jobDescription
      case pubDate, salaryMin, salaryMax, salaryCurrency, salaryPeriod
   }

   init(from decoder: Decoder) throws {
      let c = try decoder.container(keyedBy: CodingKeys.self)
      id = try c.decode(Int.self, forKey: .id)
      url = try c.decode(String.self, forKey: .url)
      jobTitle = try c.decode(String.self, forKey: .jobTitle)
      companyName = try c.decode(String.self, forKey: .companyName)
      companyLogo = try c.decode(String.self, forKey: .companyLogo)
      jobGeo = try c.decode(String.self, forKey: .jobGeo)
      jobLevel = try c.decode(String.self, forKey: .jobLevel)
      jobExcerpt = try c.decode(String.self, forKey: .jobExcerpt)
      jobDescription = try c.decode(String.self, forKey: .jobDescription)
      pubDate = try c.decode(String.self, forKey: .pubDate)
      salaryMin = try c.decodeIfPresent(Int.self, forKey: .salaryMin)
      salaryMax = try c.decodeIfPresent(Int.self, forKey: .salaryMax)
      salaryCurrency = try c.decodeIfPresent(String.self, forKey: .salaryCurrency)
      salaryPeriod = try c.decodeIfPresent(String.self, forKey: .salaryPeriod)

      // Jobicy API quirk: jobType/jobIndustry kabhi String aata he, kabhi [String]
      if let arr = try? c.decode([String].self, forKey: .jobIndustry) {
         jobIndustry = arr
      } else {
         jobIndustry = [try c.decode(String.self, forKey: .jobIndustry)]
      }
      if let arr = try? c.decode([String].self, forKey: .jobType) {
         jobType = arr
      } else {
         jobType = [try c.decode(String.self, forKey: .jobType)]
      }
   }

   init(
      id: Int,
      url: String,
      jobTitle: String,
      companyName: String,
      companyLogo: String,
      jobIndustry: [String],
      jobType: [String],
      jobGeo: String,
      jobLevel: String,
      jobExcerpt: String,
      jobDescription: String,
      pubDate: String,
      salaryMin: Int?,
      salaryMax: Int?,
      salaryCurrency: String?,
      salaryPeriod: String?
   ) {
      self.id = id
      self.url = url
      self.jobTitle = jobTitle
      self.companyName = companyName
      self.companyLogo = companyLogo
      self.jobIndustry = jobIndustry
      self.jobType = jobType
      self.jobGeo = jobGeo
      self.jobLevel = jobLevel
      self.jobExcerpt = jobExcerpt
      self.jobDescription = jobDescription
      self.pubDate = pubDate
      self.salaryMin = salaryMin
      self.salaryMax = salaryMax
      self.salaryCurrency = salaryCurrency
      self.salaryPeriod = salaryPeriod
   }
}

// MARK: - Listing screen ke liye display-ready computed property
extension Job {
   var salaryRangeText: String {
      guard let min = salaryMin, let max = salaryMax else {
         return "Salary not disclosed"
      }

      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.groupingSeparator = ","

      let minStr = formatter.string(from: NSNumber(value: min)) ?? "\(min)"
      let maxStr = formatter.string(from: NSNumber(value: max)) ?? "\(max)"
      let symbol = (salaryCurrency == "USD") ? "$" : (salaryCurrency.map { "\($0) " } ?? "")
      let periodText = salaryPeriod.map { " / \($0)" } ?? ""

      return "\(symbol)\(minStr) - \(symbol)\(maxStr)\(periodText)"
   }
}

