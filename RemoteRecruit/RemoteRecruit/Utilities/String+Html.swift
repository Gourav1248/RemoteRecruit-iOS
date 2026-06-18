//
//  String+Html.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

extension String {
   /// Jobicy API ka jobDescription HTML me aata he, isko SwiftUI Text me dikhane ke liye
   /// AttributedString me convert karta he (tags strip, formatting preserve).
   var htmlToAttributedString: AttributedString {
      guard let data = self.data(using: .utf8) else {
         return AttributedString(self)
      }
      guard let nsAttributed = try? NSAttributedString(
         data: data,
         options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
         ],
         documentAttributes: nil
      ) else {
         return AttributedString(self)
      }
      return AttributedString(nsAttributed)
   }
}

extension String {

   var removingHTMLTags: String {

      self
         .replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
         )
         .replacingOccurrences(
            of: "\n{3,}",
            with: "\n\n",
            options: .regularExpression
         )
         .replacingOccurrences(
            of: "[ \t]+",
            with: " ",
            options: .regularExpression
         )
         .trimmingCharacters(
            in: .whitespacesAndNewlines
         )
   }
}
