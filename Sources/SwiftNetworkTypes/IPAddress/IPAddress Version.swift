//
//  IPAddress Version.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension IPAddress {
    /// IP Address protocol version.
    public enum Version: Int {
            /// Valid IPv4 address.
        case ipV4 = 4

            /// Valid IPv6 address.
        case ipV6 = 6
    }
}

extension IPAddress.Version: Equatable { }

extension IPAddress.Version: Hashable { }

extension IPAddress.Version: CaseIterable { }

extension IPAddress.Version: Identifiable {
    nonisolated
    public var id: Self {
        self
    }
}

extension IPAddress.Version: Sendable { }

extension IPAddress.Version: Codable { }
