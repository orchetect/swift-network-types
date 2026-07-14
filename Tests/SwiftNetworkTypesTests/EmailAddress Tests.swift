//
//  EmailAddress Tests.swift
//  SwiftNetworkTypes • https://github.com/orchetect/swift-network-types
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import SwiftNetworkTypes
import Testing

@Suite
struct EmailAddress_Tests {
    /// Basic test to check that the validating init works.
    /// The implementation details of validation are tested in another test case using the
    /// `init(verbatim:)` init, checking the `isValid` property.
    @Test
    func validatingInit() {
        #expect(throws: Never.self) { try EmailAddress("a@b.ca") }
        #expect(throws: EmailAddress.ValidationError.invalid) { try EmailAddress("@") }
    }

    @Test
    func isValid() {
        // see isValidEmailAddress method comments for email address formatting details

        #expect(!EmailAddress(verbatim: "").isValid)
        #expect(!EmailAddress(verbatim: "@").isValid)
        #expect(!EmailAddress(verbatim: "@.").isValid)
        #expect(!EmailAddress(verbatim: ".@.").isValid)
        #expect(!EmailAddress(verbatim: "a@b.c").isValid)

        #expect(!EmailAddress(verbatim: ".user@domain.com").isValid)
        #expect(EmailAddress(verbatim: "-user@domain.com").isValid) // ?
        #expect(EmailAddress(verbatim: "+user@domain.com").isValid) // ?

        #expect(!EmailAddress(verbatim: "user.@domain.com").isValid)
        #expect(EmailAddress(verbatim: "user-@domain.com").isValid) // ?
        #expect(EmailAddress(verbatim: "user+@domain.com").isValid) // ?

        // prefix: can't start or end with period
        #expect(!EmailAddress(verbatim: ".a@domain.com").isValid)
        #expect(!EmailAddress(verbatim: "a.@domain.com").isValid)
        #expect(EmailAddress(verbatim: "a-@domain.com").isValid) // ?
        #expect(EmailAddress(verbatim: "a+@domain.com").isValid) // ?

        #expect(EmailAddress(verbatim: "a@b.ca").isValid)
        #expect(EmailAddress(verbatim: "aa@b.ca").isValid)
        #expect(EmailAddress(verbatim: "a@bb.ca").isValid)
        #expect(EmailAddress(verbatim: "aa@bb.ca").isValid)

        #expect(EmailAddress(verbatim: "user@domain.com").isValid)
        #expect(EmailAddress(verbatim: "user@subdomain.domain.com").isValid)

        #expect(EmailAddress(verbatim: "first.last@domain.com").isValid)
        #expect(EmailAddress(verbatim: "first.last@subdomain.domain.com").isValid)

        // prefix: can't contain two or more consecutive periods
        #expect(!EmailAddress(verbatim: "first..last@domain.com").isValid)

        #expect(EmailAddress(verbatim: "first+last@domain.com").isValid)
        #expect(EmailAddress(verbatim: "first+last@subdomain.domain.com").isValid)

        #expect(EmailAddress(verbatim: "first-last@domain.com").isValid)
        #expect(EmailAddress(verbatim: "first-last@subdomain.domain.com").isValid)

        #expect(EmailAddress(verbatim: "user@some-domain.com").isValid)
        #expect(EmailAddress(verbatim: "user@subdomain.some-domain.com").isValid)

        // domain: can't start or end with hyphen
        #expect(!EmailAddress(verbatim: "user@-somedomain.com").isValid)
        #expect(!EmailAddress(verbatim: "user@somedomain-.com").isValid)

        #expect(EmailAddress(verbatim: "user@123456.com").isValid)

        // domain: 70 chars, too many
        #expect(
            !EmailAddress(
                verbatim: "user@1234567890123456789012345678901234567890123456789012345678901234567890.com"
            )
            .isValid
        )

        // domain: 63 chars max, is valid
        #expect(
            EmailAddress(verbatim: "user@890123456789012345678901234567890123456789012345678901234567890.com")
                .isValid
        )

        // TLD: can't be all numbers
        #expect(!EmailAddress(verbatim: "user@domain.123").isValid)

        // TLD: only latin alphabet
        #expect(!EmailAddress(verbatim: "user@domain.c-m").isValid)

        // hostname: must not exceed 255 characters
        // 256 characters
        #expect(
            !EmailAddress(
                verbatim: "user@1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.com"
            )
            .isValid
        )

        // hostname: must not exceed 255 characters
        // 255 characters
        #expect(
            EmailAddress(
                verbatim: "user@1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.1234567890.123456789.com"
            ).isValid
        )
    }
}

#endif
