//
//  DomainName.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A type representing a domain name (ie: `apple.com`, `www.apple.com`, `sub.domain.www.zzz`).
public struct DomainName {
    /// Individual domain name components (domain name split by period (`.`) characters).
    nonisolated
    public let components: [String]

    /// The number of domain extension components included in the domain extension.
    ///
    /// For example:
    /// - `"www.apple.com"` would have `1` component (`"com"`).
    /// - `"www.apple.co.uk"` would have `2` components (`"co"` and `"uk"`).
    nonisolated
    public let extensionComponentCount: Int

    /// Initialize a new instance from a domain name string.
    nonisolated
    public init(_ verbatim: String) {
        components = verbatim.split(separator: ".").map(String.init)
        extensionComponentCount = Self.extensionComponentCount(inDomainComponents: components)
    }

    /// Initialize a new instance from domain name components (domain name split by period (`.`)
    /// characters).
    nonisolated
    public init(components: [String]) {
        self.components = components
        extensionComponentCount = Self.extensionComponentCount(inDomainComponents: components)
    }
}

extension DomainName: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.components == rhs.components
    }
}

extension DomainName: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(components)
    }
}

extension DomainName: Identifiable {
    nonisolated
    public var id: String {
        string
    }
}

extension DomainName: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self.init(string)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}

extension DomainName: Sendable { }

extension DomainName: CustomStringConvertible {
    nonisolated
    public var description: String {
        string
    }
}
