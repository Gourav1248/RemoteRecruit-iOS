//
//  JobDetailsView.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import SwiftUI

struct JobDetailView: View {
   let job: Job

   init(job: Job) {
      self.job = job
   }

   var body: some View {
      ScrollView {
         VStack(alignment: .leading, spacing: 0) {
            heroSection
            descriptionCard
               .padding()
         }
      }
      .background(Color(.systemGroupedBackground))
      .navigationTitle("Job Details")
      .navigationBarTitleDisplayMode(.inline)
      .safeAreaInset(edge: .bottom) {
         if let applyURL = URL(string: job.url) {
            Link(destination: applyURL) {
               Text("Apply Now")
                  .font(.headline)
                  .foregroundStyle(.white)
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 14)
                  .background(Color.blue)
                  .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding()
            .background(.bar)
         }
      }
   }

   // MARK: - Hero: logo + "Company is hiring a" + big title + info grid
   private var heroSection: some View {
      VStack(alignment: .leading, spacing: 20) {
         companyLogo

         (
            Text(job.companyName)
               .foregroundColor(.blue)
               .fontWeight(.semibold)
            + Text(" is hiring a")
               .foregroundColor(.primary)
         )
         .font(.title3)

         Text(job.jobTitle)
            .font(.system(size: 30, weight: .bold))
            .fixedSize(horizontal: false, vertical: true)

         infoGrid
      }
      .padding(20)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color.white)
   }

   private var companyLogo: some View {

      Circle()
         .fill(.blue)
         .frame(width: 60, height: 60)
         .overlay {
            Text(String(job.companyName.prefix(1)))
               .font(.title)
               .fontWeight(.bold)
               .foregroundStyle(.white)
         }
   }

   private var infoGrid: some View {
      Grid(alignment: .leading, horizontalSpacing: 28, verticalSpacing: 18) {
         GridRow {
            infoItem(title: "Location", value: job.jobGeo)
            infoItem(title: "Annual Salary", value: job.salaryRangeText)
         }
         GridRow {
            infoItem(title: "Employment Type", value: job.jobType.joined(separator: ", "))
            infoItem(title: "Experience Level", value: job.jobLevel)
         }
         GridRow {
            infoItem(title: "Industry", value: job.jobIndustry.joined(separator: ", "))
            infoItem(title: "Job Posted", value: job.pubDate.formattedDate)
         }
      }
   }

   private func infoItem(title: String, value: String) -> some View {
      VStack(alignment: .leading, spacing: 4) {
         Text(title)
            .font(.subheadline)
            .foregroundStyle(.secondary)
         Text(value)
            .font(.body.weight(.semibold))
            .lineLimit(2)
      }
   }

   // MARK: - Description
   private var descriptionCard: some View {
      VStack(alignment: .leading, spacing: 10) {
         Text("Job Description")
            .font(.headline)
         Text(job.jobDescription.removingHTMLTags)
            .font(.subheadline)
            .foregroundStyle(.primary)
            .lineSpacing(4)
      }
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color(.secondarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16))
   }

}

