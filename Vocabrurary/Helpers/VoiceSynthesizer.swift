//
//  VoiceSynthesizer.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import AVFoundation

class VoiceSynthesizeService {
    
    enum VoiceSpeed {
        case slow
        case mid
        case fast
        
        var value: Float {
            switch self {
            case .slow:
                return AVSpeechUtteranceMinimumSpeechRate
            case .mid:
                return AVSpeechUtteranceDefaultSpeechRate
            case .fast:
                return AVSpeechUtteranceMaximumSpeechRate
            }
        }
    }
    
    let synthhesizer: AVSpeechSynthesizer
    
    init() {
        synthhesizer = AVSpeechSynthesizer()
    }
    
    func speack(it text: String, speed: VoiceSpeed = .mid) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = speed.value
                
        if synthhesizer.isSpeaking {
            synthhesizer.stopSpeaking(at: .immediate)
        }
        
        synthhesizer.speak(utterance)
    }
}
