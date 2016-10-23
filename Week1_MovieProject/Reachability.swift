//
//  Reachability.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/22/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import SystemConfiguration

func sizeof<T>(_ : T.Type) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof<T>(_ : T) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof<T>(_ value: [T]) -> Int {
    return (MemoryLayout<T>.size * value.count)
}

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeof(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: UInt32(0))
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags.contains(SCNetworkReachabilityFlags.reachable)
        let needsConnection = flags.contains(SCNetworkReachabilityFlags.connectionRequired)
        
        return isReachable && !needsConnection
    }
}
