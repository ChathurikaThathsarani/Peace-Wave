//
//  Audio.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import Foundation

struct Audio: Identifiable, Equatable {
    let id = UUID()
    let title: String
    var isPlaying: Bool = false
    
//    static func ==: This is a static method that overrides the default implementation of the equality operator (==) for the Audio struct.
//    lhs: Left-hand side parameter of type Audio.
//    rhs: Right-hand side parameter of type Audio.
//    lhs.id == rhs.id: It compares the id properties of the two Audio instances. If they are equal, the method returns true, indicating the two instances are equal; otherwise, it returns false.
    static func == (lhs: Audio, rhs: Audio) -> Bool {
        lhs.id == rhs.id
    }
}
