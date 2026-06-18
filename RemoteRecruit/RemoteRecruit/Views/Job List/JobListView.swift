//
//  JobListView.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import SwiftUI

struct JobListView: View {

   @StateObject private var viewModel = JobListViewModel()
    var body: some View {
       NavigationStack {
          Group {
             if viewModel.isLoading && viewModel.jobs.isEmpty {
                ProgressView("Loading jobs...")
             } else if !viewModel.isConnected && viewModel.jobs.isEmpty {
                statusView(
                  icon: "wifi.slash",
                  title: "No Internet Connection",
                  message: "Please check your network and try again."
                )
             } else if let errorMessage = viewModel.errorMessage, viewModel.jobs.isEmpty {
                statusView(
                  icon: "exclamationmark.triangle",
                  title: "Something Went Wrong",
                  message: errorMessage
                )
             } else if viewModel.filteredJobs.isEmpty {
                statusView(
                  icon: "magnifyingglass",
                  title: "No Jobs Found",
                  message: "Try a different title or company name"
                )
             } else {
                List(viewModel.filteredJobs) { job in
                   NavigationLink {
                      JobDetailView(job: job)
                   } label: {

                      JobCellView(job: job)
                         .listRowSeparator(.hidden)
                         .listRowBackground(Color.clear)
                   }
                }
                .listStyle(.plain)
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
             }
          }
          .navigationTitle("Jobs")
          .searchable(text: $viewModel.searchText, prompt: "Search by title or company")
          .task {
             await viewModel.fetchJobs()
          }

          .refreshable {
             await viewModel.fetchJobs()
          }
//          .alert("Something went wrong", isPresented: errorBinding) {
//             Button("OK") {
//                viewModel.errorMessage = nil
//             }
//          }
       }
    }


   private var errorBinding: Binding<Bool> {
      Binding(
         get: { viewModel.errorMessage != nil },
         set: { if !$0 { viewModel.errorMessage = nil } }
      )
   }

   private func statusView(icon: String, title: String, message: String) -> some View {
      VStack(spacing: 12) {
         Image(systemName: icon)
            .font(.system(size: 40))
            .foregroundStyle(.secondary)
         Text(title)
            .font(.headline)
         Text(message)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)

         if icon != "magnifyingglass" {
            Button("Retry") {
               Task { await viewModel.fetchJobs() }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 4)
         }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
   }
}

struct JobListView_Previews: PreviewProvider {
    static var previews: some View {
        JobListView()
    }
}
