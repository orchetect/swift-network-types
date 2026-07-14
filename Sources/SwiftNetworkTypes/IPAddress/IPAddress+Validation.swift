//
//  IPAddress+Validation.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

extension IPAddress {
    /// Initialize by validating an IP address, throwing an error if the address is not valid.
    /// After successful initialization, the ``version`` property will contain the detected IP address protocol.
    nonisolated
    public init(_ address: String) throws(ValidationError) {
        self.address = address
        version = try Self._validatedVersion(ipAddress: address)
    }

    /// Performs validation on the IP address and returns the IP protocol version if the IP address is valid.
    /// Throws an error if the IP address fails validation.
    nonisolated
    static func _validatedVersion(ipAddress address: String) throws(ValidationError) -> Version {
        // first test for IPv4
        if address
            .regexMatches(pattern: Self.ipV4Pattern, matchesOptions: [.anchored])
            .count == 1
        {
            return .ipV4
        }

        // secondly, test for IPv6
        if address
            .regexMatches(pattern: Self.ipV6Pattern, matchesOptions: [.anchored])
            .count == 1
        {
            return .ipV6
        }

        // if all tests failed, return invalid - does not match any known IP address format
        throw .invalid
    }
}

// MARK: - Internal

extension IPAddress {
    /// Internal:
    /// IPv4 IP Address Validation Pattern.
    nonisolated
    private static let ipV4Pattern =
        #"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"#

    /// Internal:
    /// IPv6 IP Address Validation Pattern.
    ///
    /// As suggested from:
    /// http://nbviewer.jupyter.org/github/rasbt/python_reference/blob/master/tutorials/useful_regex.ipynb#Checking-for-IP-addresses
    nonisolated
    private static let ipV6Pattern =
        #"^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$"#
}

#endif
