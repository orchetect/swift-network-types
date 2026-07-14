//
//  ReverseDomainName+Properties.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension ReverseDomainName {
    /// Returns the full reverse-notation domain name string including all components.
    nonisolated
    public var string: String {
        components.joined(separator: ".")
    }

    /// Returns the prefix components of the reverse-notation domain name, if any are present.
    ///
    /// For example:
    /// - `"com.apple"` or `"uk.co.apple"` returns `""`
    /// - `"com.apple.www"` or `"uk.co.apple.www"` returns `"www"`
    /// - `"com.apple.www.zzz"` returns `"www.zzz"`
    nonisolated
    public var prefix: String {
        prefixComponents.joined(separator: ".")
    }

    /// Returns the prefix components of the domain name, if any are present.
    ///
    /// For example:
    /// - `"com.apple"` or `"uk.co.apple"` returns `[]`
    /// - `"com.apple.www"` or `"uk.co.apple.www"` returns `["www"]`
    /// - `"com.apple.www.zzz"` returns `["www", "zzz"]`
    nonisolated
    public var prefixComponents: [String] {
        let prefixCount = max(0, components.count - (extensionComponentCount + 1))
        return Array(components.suffix(prefixCount))
    }

    /// Returns the domain component of the domain name.
    ///
    /// For example:
    /// - `"com.apple"` or `"com.apple.www"` returns `"apple"`
    /// - `"uk.co.apple"` or `"uk.co.apple.www"` returns `"apple"`
    nonisolated
    public var domainComponent: String {
        components.dropFirst(extensionComponentCount).first ?? ""
    }

    /// Returns the domain and extension of the domain name.
    ///
    /// For example:
    /// - `"com.apple"` or `"com.apple.www"` returns `"com.apple"`
    /// - `"uk.co.apple"` or `"uk.co.apple.www"` returns `"uk.co.apple"`
    nonisolated
    public var domainAndExtension: String {
        domainAndExtensionComponents.joined(separator: ".")
    }

    /// Returns the domain and extension of the domain name.
    ///
    /// For example:
    /// - `"com.apple"` or `"com.apple.www"` returns `["com", "apple"]`
    /// - `"uk.co.apple"` or `"uk.co.apple.www"` returns `["uk", "co", "apple"]`
    nonisolated
    public var domainAndExtensionComponents: [String] {
        Array(components.prefix(extensionComponentCount + 1))
    }

    /// Returns the extension for the domain name.
    ///
    /// For example:
    /// - `"com.apple"` or `"com.apple.www"` returns `"com"`
    /// - `"uk.co.apple"` or `"uk.co.apple.www"` returns `"uk.co"`
    nonisolated
    public var domainExtension: String {
        domainExtensionComponents.joined(separator: ".")
    }

    /// Returns the extension for the domain name.
    ///
    /// For example:
    /// - `"com.apple"` or `"com.apple.www"` returns `["com"]`
    /// - `"uk.co.apple"` or `"uk.co.apple.www"` returns `["uk", "co"]`
    nonisolated
    public var domainExtensionComponents: [String] {
        Array(components.prefix(extensionComponentCount))
    }
}
