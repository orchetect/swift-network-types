//
//  DomainName+Properties.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension DomainName {
    /// Returns the full domain name string including all components.
    nonisolated
    public var string: String {
        components.joined(separator: ".")
    }

    /// Returns the prefix components of the domain name, if any are present.
    ///
    /// For example:
    /// - `"apple.com"` or `"apple.co.uk"` returns `""`
    /// - `"www.apple.com"` or `"www.apple.co.uk"` returns `"www"`
    /// - `"zzz.www.apple.com"` returns `"zzz.www"`
    nonisolated
    public var prefix: String {
        prefixComponents.joined(separator: ".")
    }

    /// Returns the prefix components of the domain name, if any are present.
    ///
    /// For example:
    /// - `"apple.com"` or `"apple.co.uk"` returns `[]`
    /// - `"www.apple.com"` or `"www.apple.co.uk"` returns `["www"]`
    /// - `"zzz.www.apple.com"` returns `["zzz", "www"]`
    nonisolated
    public var prefixComponents: [String] {
        let prefixCount = max(0, components.count - (extensionComponentCount + 1))
        return Array(components.prefix(prefixCount))
    }

    /// Returns the domain component of the domain name.
    ///
    /// For example:
    /// - `"apple.com"` or `"www.apple.com"` returns `"apple"`
    /// - `"apple.co.uk"` or `"www.apple.co.uk"` returns `"apple"`
    nonisolated
    public var domainComponent: String {
        components.dropLast(extensionComponentCount).last ?? ""
    }

    /// Returns the domain and extension of the domain name.
    ///
    /// For example:
    /// - `"apple.com"` or `"www.apple.com"` returns `"apple.com"`
    /// - `"apple.co.uk"` or `"www.apple.co.uk"` returns `"apple.co.uk"`
    nonisolated
    public var domainAndExtension: String {
        domainAndExtensionComponents.joined(separator: ".")
    }

    /// Returns the domain and extension of the domain name.
    ///
    /// For example:
    /// - `"apple.com"` or `"www.apple.com"` returns `["apple", "com"]`
    /// - `"apple.co.uk"` or `"www.apple.co.uk"` returns `["apple", "co", "uk"]`
    nonisolated
    public var domainAndExtensionComponents: [String] {
        components.suffix(extensionComponentCount + 1)
    }

    /// Returns the extension for the domain name.
    ///
    /// For example:
    /// - `"apple.com"` or `"www.apple.com"` returns `"com"`
    /// - `"apple.co.uk"` or `"www.apple.co.uk"` returns `"co.uk"`
    nonisolated
    public var domainExtension: String {
        domainExtensionComponents.joined(separator: ".")
    }

    /// Returns the extension for the domain name.
    ///
    /// For example:
    /// - `"apple.com"` or `"www.apple.com"` returns `["com"]`
    /// - `"apple.co.uk"` or `"www.apple.co.uk"` returns `["co", "uk"]`
    nonisolated
    public var domainExtensionComponents: [String] {
        components.suffix(extensionComponentCount)
    }
}
