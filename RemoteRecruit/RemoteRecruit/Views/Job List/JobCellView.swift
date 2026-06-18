//
//  JobCellView.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import SwiftUI

struct JobCellView: View {
   let job: Job

    var body: some View {
       VStack(alignment: .leading, spacing: 6) {
          Text(job.jobTitle)
             .font(.headline)
             .padding(2)

          Text(job.companyName)
             .font(.subheadline)
             .foregroundStyle(.secondary)
             .padding(2)

          HStack {
             Label("Job location: \(job.jobGeo)", systemImage: "location")
             Spacer()
             Text(job.salaryRangeText)
                .foregroundStyle(.green)
          }
          .padding(2)
          .font(.caption)
       }
       .padding(8)
       .background(.white)
       .clipShape(RoundedRectangle(cornerRadius: 10))
       .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
    }
}

//struct JobCellView_Previews: PreviewProvider {
//    static var previews: some View {
//       JobCellView(job: Job)
//    }
//}
