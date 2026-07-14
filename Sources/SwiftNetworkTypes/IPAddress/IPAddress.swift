//
//  IPAddress.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation

/// IP Address Format Validation.
public struct IPAddress {
    /// IP Address string.
    nonisolated
    public var address: String = ""

    /// Validated IP address format.
    nonisolated
    public var version: Version

    /// Initialize from an IP address string and IP protocol version without performing validation.
    nonisolated
    public init(verbatim string: String, version: Version) {
        address = string
        self.version = version
    }
}

extension IPAddress: Equatable { }

extension IPAddress: Hashable { }

extension IPAddress: Identifiable {
    nonisolated
    public var id: String {
        address
    }
}

extension IPAddress: Sendable { }

extension IPAddress: Codable { }

#endif
