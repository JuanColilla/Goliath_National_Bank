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
    
    /// Instancia global / Singleton
    static let sharedInstance = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        
    }
    
    /// Se comprobará mientras la app esté abierta la conectividad de red.
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    /// Detener la constante comprobación de conectividad de red.
    public func stopMonitoring() {
        monitor.cancel()
    }
    
}
