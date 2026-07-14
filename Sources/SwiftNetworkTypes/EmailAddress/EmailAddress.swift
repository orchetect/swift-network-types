//
//  EmailAddress.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A type representing an email address.
public struct EmailAddress {
    /// Email address.
    nonisolated
    public let string: String

    /// Initialize from an email address string without performing validation.
    nonisolated
    public init(verbatim address: String) {
        self.string = address
    }
}

extension EmailAddress: Equatable { }

extension EmailAddress: Hashable { }

extension EmailAddress: Sendable { }

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
        self.init(verbatim: string)
    }

    nonisolated
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}

extension EmailAddress: CustomStringConvertible {
    nonisolated
    public var description: String {
        string
    }
}
