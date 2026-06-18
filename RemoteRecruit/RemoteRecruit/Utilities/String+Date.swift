//
//  String+Date.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 17/06/26.
//

import Foundation

extension String {

   var formattedDate: String {

      let inputFormatter = ISO8601DateFormatter()

      guard let date = inputFormatter.date(from: self) else {
         return self
      }

      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = "dd MMM yyyy"

      return outputFormatter.string(from: date)
   }
}
