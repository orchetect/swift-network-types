//
//  EmailAddress ValidationError.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension EmailAddress {
    /// Email address validation error.
    public enum ValidationError: Error {
        case invalid
    }
}

extension EmailAddress.ValidationError: Equatable { }

extension EmailAddress.ValidationError: Hashable { }

extension EmailAddress.ValidationError: CaseIterable { }

extension EmailAddress.ValidationError: Identifiable {
    nonisolated
    public var id: Self {
        self
    }
}

extension EmailAddress.ValidationError: Sendable { }
