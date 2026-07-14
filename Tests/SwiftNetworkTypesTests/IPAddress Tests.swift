//
//  IPAddress Tests.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import SwiftNetworkTypes
import Testing

@Suite
struct IPAddress_Tests {
    @Test
    func ipAddressIPv4Valid() throws {
        // valid unspecified
        #expect(try IPAddress("0.0.0.0").version == .ipV4)

        // typical examples
        #expect(try IPAddress("10.0.0.100").version == .ipV4)
        #expect(try IPAddress("255.255.255.255").version == .ipV4)
        #expect(try IPAddress("001.001.001.001").version == .ipV4)
    }

    @Test
    func ipAddressIPv4Invalid() throws {
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("...") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress(" . . . ") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("300.300.300.300") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("300.1.1.1") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1.300.1.1") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1.1.300.1") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1.1.1.300") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1 .102.103.104") }
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1.2.3.4.5") }

        // no surrounding spaces allowed, even if IP address is valid
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress(" 1.2.3.4 ") }
    }

    @Test
    func ipAddressIPv6Valid() throws {
        // local loopback address
        #expect(try IPAddress("::1").version == .ipV6)

        // valid unspecified
        #expect(try IPAddress("::").version == .ipV6)

        // includes interface component
        #expect(try IPAddress("fe80::479:5a0d:bf0f:130%en0").version == .ipV6)

        // includes interface component
        #expect(try IPAddress("fe80::c6a:a089:1eec:80a7%awdl0").version == .ipV6)
        #expect(try IPAddress("2001:470:9b36:1::2").version == .ipV6)
        #expect(try IPAddress("2001:cdba:0000:0000:0000:0000:3257:9652").version == .ipV6)
        #expect(try IPAddress("2001:cdba:0:0:0:0:3257:9652").version == .ipV6)
        #expect(try IPAddress("2001:db8:85a3::8a2e:370:7334").version == .ipV6)

        // IPv4 address mapped to IPv6
        #expect(try IPAddress("::ffff:192.0.2.128").version == .ipV6)
    }

    @Test
    func ipAddressIPv6Invalid() throws {
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("::_") }

        // uses '::' twice - not allowed
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1200::AB00:1234::2552:7777:1313") }

        // contains an invalid non-hex character (`O`)
        #expect(throws: IPAddress.ValidationError.invalid) { try IPAddress("1200:0000:AB00:1234:O000:2552:7777:1313") }
    }
}

#endif
