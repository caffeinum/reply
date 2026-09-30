import Foundation

/// Sign-in codes, found on this mac: a subject or preview that talks about a
/// code, and the 4–8 character token it gives. Nothing is sent anywhere.
public enum Codes {
    public static let window: Int64 = 30 * 60 * 1000

    private static let cue = try! NSRegularExpression(
        pattern: #"\b(code|codes|verif\w*|otp|one[- ]time|passcode|password|2fa|two[- ]factor|sign[- ]?in|log[- ]?in|logging|security|authenticat\w*|confirm\w*|pin)\b|код|кода"#,
        options: [.caseInsensitive])
    private static let token = try! NSRegularExpression(
        pattern: #"(?<![\w$€£.,:/#])(\d{3}[- ]\d{3}|\d{4,8}|(?=[A-Z0-9]*\d)(?=[A-Z0-9]*[A-Z])[A-Z0-9]{5,8}|[A-Z0-9]{3,4}-[A-Z0-9]{3,4})(?![\w,:/%-]|\.\w)"#)

    public static func find(subject: String, snippet: String) -> String? {
        let both = subject + " " + snippet
        guard cue.firstMatch(in: both, range: NSRange(location: 0, length: (both as NSString).length)) != nil else { return nil }
        for text in [subject, snippet] {
            let whole = text as NSString
            for m in token.matches(in: text, range: NSRange(location: 0, length: whole.length)) {
                let t = whole.substring(with: m.range(at: 1))
                if t.count == 4, let y = Int(t), (1900...2100).contains(y) { continue }
                return t
            }
        }
        return nil
    }
}
