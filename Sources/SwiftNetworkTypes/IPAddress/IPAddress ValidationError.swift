//
//  IPAddress ValidationError.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension IPAddress {
    /// IP Address validation error.
    public enum ValidationError: Error {
        case invalid
    }
}

extension IPAddress.ValidationError: Equatable { }

extension IPAddress.ValidationError: Hashable { }

extension IPAddress.ValidationError: CaseIterable { }

extension IPAddress.ValidationError: Identifiable {
    nonisolated
    public var id: Self {
        self
    }
}

extension IPAddress.ValidationError: Sendable { }
