//
//  NetworkMonitor.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import Foundation
import Network
import SystemConfiguration

class NetworkMonitor {
    
    static let sharedInstance = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        
    }
    
    /// Network connectivity will be constantly monitored.
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    /// Network connectivity will stop being monitored.
    public func stopMonitoring() {
        monitor.cancel()
    }
    
}
