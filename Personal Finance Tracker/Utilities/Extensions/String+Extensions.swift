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
}
