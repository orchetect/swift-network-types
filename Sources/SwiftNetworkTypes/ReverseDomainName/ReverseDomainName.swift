//
//  ReverseDomainName.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A type representing a domain name in reverse-notation (ie: `com.apple`, `com.apple.www`,
/// `com.apple.www.zzz`).
public struct ReverseDomainName {
    /// Individual domain name components (domain name split by period (`.`) characters).
    nonisolated
    public let components: [String]

    /// The number of domain extension components included in the domain extension.
    ///
    /// For example:
    /// - `"com.apple.www"` would have `1` component (`"com"`).
    /// - `"uk.co.apple.www"` would have `2` components (`"uk"` and `"co"`).
    nonisolated
    public let extensionComponentCount: Int

    /// Initialize a new instance from a reverse-notation domain name string.
    nonisolated
    public init(_ domainName: String) {
        components = domainName
            .split(separator: ".")
            .map(String.init)

        extensionComponentCount = DomainName.extensionComponentCount(
            inDomainComponents: components.reversed()
        )
    }

    /// Initialize a new instance from reverse-notation domain name components (domain name split by
    /// period (`.`) characters).
    nonisolated
    public init(components: [String]) {
        self.components = components

        extensionComponentCount = DomainName.extensionComponentCount(
            inDomainComponents: components.reversed()
        )
    }
}

extension ReverseDomainName: Equatable {
    nonisolated
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.components == rhs.components
    }
}

extension ReverseDomainName: Hashable {
    nonisolated
    public func hash(into hasher: inout Hasher) {
        hasher.combine(components)
    }
}

extension ReverseDomainName: Sendable { }

extension ReverseDomainName: Identifiable {
    nonisolated
    public var id: String {
        string
    }
}

extension ReverseDomainName: Codable {
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

extension ReverseDomainName: CustomStringConvertible {
    nonisolated
    public var description: String {
        string
    }
}
