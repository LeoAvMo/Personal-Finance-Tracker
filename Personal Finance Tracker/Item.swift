//
//  Item.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 16/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
