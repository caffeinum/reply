import Testing
@testable import MailCore

@Suite struct SignInCodes {
    @Test func findsCodes() {
        #expect(Codes.find(subject: "Your verification code is 482913", snippet: "") == "482913")
        #expect(Codes.find(subject: "Sign in to Vercel", snippet: "Your code: 123-456. It expires in 10 minutes.") == "123-456")
        #expect(Codes.find(subject: "G-583021 is your Google verification code", snippet: "") == "583021")
        #expect(Codes.find(subject: "Your Slack confirmation code: KZT-4QX", snippet: "") == "KZT-4QX")
        #expect(Codes.find(subject: "Login code", snippet: "Enter 7H2K9P to finish logging in") == "7H2K9P")
    }

    @Test func leavesOrdinaryMailAlone() {
        #expect(Codes.find(subject: "Your receipt from Acme #2041", snippet: "$49.00 paid") == nil)
        #expect(Codes.find(subject: "Issue 42: tools that feel like nothing", snippet: "why the best tools") == nil)
        #expect(Codes.find(subject: "Security update for 2026", snippet: "we changed our terms") == nil)
        #expect(Codes.find(subject: "Your flight is booked", snippet: "Confirmation code KX7PQ2") == "KX7PQ2")
    }
}
