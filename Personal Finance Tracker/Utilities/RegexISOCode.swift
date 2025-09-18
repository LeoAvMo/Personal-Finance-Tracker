//
//  RegexTextField.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 17/09/25.
//

import SwiftUI
import RegexBuilder

let ISOCodeRegex = Regex {
    Repeat(count: 3) {
        ("A"..."Z")
    }
}

func isValidISOCode(ISOCode: String) -> Bool {
    (try? ISOCodeRegex.wholeMatch(in: ISOCode)) != nil
}
