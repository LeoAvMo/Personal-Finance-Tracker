//
//  Extensions.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 30/08/25.
//

import SwiftUI

extension String {
    func summarizeString(length: Int, stringToTrail: String = "...") -> String{
        return (self.count > length) ? String(self.prefix(length)) + stringToTrail : self
    }
    
    
    // Code gotten from: https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji by Kevin R
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
