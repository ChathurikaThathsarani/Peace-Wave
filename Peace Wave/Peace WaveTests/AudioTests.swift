//
//  AudioTests.swift
//  Peace WaveTests
//
//  Created by Chathurika Dombepola on 2024-06-10.
//

import XCTest
@testable import Peace_Wave

class AudioTests: XCTestCase {
    
    func testAudioInitialization() {
        // Given
        let title = "Relaxing Music"
        
        // When
        let audio = Audio(title: title)
        
        // Then
        XCTAssertEqual(audio.title, title)
        XCTAssertFalse(audio.isPlaying)
    }
    
    func testAudioEquality() {
        // Given
        let title1 = "Relaxing Music"
        let title2 = "Nature Sounds"
        
        let audio1 = Audio(title: title1)
        let audio2 = Audio(title: title1) // Same title but different id
        let audio3 = Audio(title: title2)
        
        // When
        let audioEqual1 = audio1 == audio2 // Should be false because of different UUIDs
        let audioEqual2 = audio1 == audio1 // Should be true because it's the same instance
        let audioEqual3 = audio1 == audio3 // Should be false because of different UUIDs and titles
        
        // Then
        XCTAssertFalse(audioEqual1)
        XCTAssertTrue(audioEqual2)
        XCTAssertFalse(audioEqual3)
    }
}
