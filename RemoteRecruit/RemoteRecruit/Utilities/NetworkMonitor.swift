//
//  NetworkMonitor.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 17/06/26.
//

import Foundation
import Network



/// Real-time internet connectivity track karta he, Network framework use karke.
/// Singleton he kyunki path monitoring ek hi instance se chalni chahiye poori app me.
final class NetworkMonitor: ObservableObject {
   static let shared = NetworkMonitor()

   @Published private(set) var isConnected = true

   private let monitor = NWPathMonitor()
   private let queue = DispatchQueue(label: "NetworkMonitor")

   private init() {
      monitor.pathUpdateHandler = { [weak self] path in
         DispatchQueue.main.async {
            self?.isConnected = path.status == .satisfied
         }
      }
      monitor.start(queue: queue)
   }
}

