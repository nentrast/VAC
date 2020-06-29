//
//  WordsRepository.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 04.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

class WordsRepository: WordRepositoryInput {
    func getAll(completion: ((Result<[Word], Error>) -> Void)) {
        let models: [Word] = [Word(original: "Stol", translate: "Table", progress: 0.5),
          Word(original: "Stol1", translate: "Table1", progress: 0.6),
          Word(original: "Teacher", translate: "Table2", progress: 0.1),
          Word(original: "Huicher", translate: "Table3"),
          Word(original: "Test", translate: "Table4", progress: 0.8),
          Word(original: "Stol5", translate: "Table5"),
          Word(original: "Transctiption", translate: "Table6", progress: 0.9),
          Word(original: "Stol7", translate: "Table7"),
          Word(original: "Stol8", translate: "Table8", progress: 0.3)]
        
        completion(.success(models))
    }
}
