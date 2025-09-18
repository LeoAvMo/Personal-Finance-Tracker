//
//  Character+Extensions.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 16/09/25.
//

import SwiftUI

extension Character {
    /// A simple check to see if a character is an emoji.
    var isEmoji: Bool {
        // The first scalar is the base character, we can check that
        guard let firstScalar = self.unicodeScalars.first else {
            return false
        }
        
        // Check if the scalar is in a recognized emoji range and has the emoji presentation property
        return firstScalar.properties.isEmoji && firstScalar.properties.isEmojiPresentation
    }
    
    /// A simple emoji is one scalar and presented to the user as an Emoji
        var isSimpleEmoji: Bool {
            guard let firstScalar = unicodeScalars.first else { return false }
            return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
        }

        /// Checks if the scalars will be merged into an emoji
        var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

        var isAnEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
    
}

