//
//  Word.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 02.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

class Word: Codable, Hashable {
    let original: String
    let translate: String
    let image: Data?
    let soundData: Data?
    let progress: Float
    let altTranslates: [WordTranslate]
    let collection: WordCollection?
    
    init(original: String, translate: String, progress: Float = 0.0, altTranslates: [WordTranslate] = []) {
        self.original = original
        self.translate = translate
        self.progress = progress
        self.altTranslates = altTranslates
        soundData = nil
        image = nil
        collection = nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(original)
        hasher.combine(translate)
    }

    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.original == rhs.original && lhs.translate == rhs.translate
    }
}

struct WordCollection: Codable {
    let name: String
    let count: Int
    let words: [Word]
}

struct WordTranslate: Codable {
    let word: String
    let transcription: String
    let soundData: Data
    let image: Data
}
