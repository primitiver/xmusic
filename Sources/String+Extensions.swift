import Foundation

extension String {
    var normalizedMusicUrl: String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return "" }
        if trimmed.hasPrefix("http") { return trimmed }
        if trimmed.hasPrefix("//") { return "https:" + trimmed }
        return "https://www.jbsou.cn/" + (trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed)
    }
}
