//
//  EmailAddress.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation

/// Email Address Format Validation.
public struct EmailAddress {
    /// Email address.
    nonisolated
    public let string: String

    /// Email Address Format Validation.
    nonisolated
    public init(_ string: String) {
        self.string = string
    }
}

extension EmailAddress: Equatable { }

extension EmailAddress: Hashable { }

extension EmailAddress: Identifiable {
    nonisolated
    public var id: String {
        string
    }
}

extension EmailAddress: Codable {
    nonisolated
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self.init(string)
    }

    nonisolated
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}

extension EmailAddress: Sendable { }

extension EmailAddress: CustomStringConvertible {
    nonisolated
    public var description: String {
        string
    }
}


#endif
