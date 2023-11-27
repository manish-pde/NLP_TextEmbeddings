//
//  ContentViewModel.swift
//  NLP_TextEmbeddings
//
//  Created by Manish on 23/11/23.
//

import Foundation
import NaturalLanguage


class ContentViewModel: ObservableObject {
    
    @Published private(set) var distanceResult = "--"
    @Published private(set) var relatedResult = "--"
    
    func checkDistance(for txt1: String, txt2: String, txt3: String) {
        distanceResult = """
        \(txt1) -> \(txt2) => \(findDistanceBetween(word1: txt1, word2: txt2))
        \(txt1) -> \(txt3) => \(findDistanceBetween(word1: txt1, word2: txt3))
        \(txt2) -> \(txt3) => \(findDistanceBetween(word1: txt2, word2: txt3))
        """
    }
    
    func findRelatedWords(for word: String) {
        guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { relatedResult = "NA"; return }
        
        var result = [String: String]()
        embedding.enumerateNeighbors(for: word, maximumCount: 5) { relWord, dis in
            result[relWord] = dis.formatted(.percent)
            return true
        }
        
        print(generateEmbeddings(for: word))
        
        relatedResult = """
        \(word) =>
        \(result)
        """
    }
    
    private func generateEmbeddings(for word: String) -> [Double] {
        guard let embedding = NLEmbedding.wordEmbedding(for: .english),
              let vectors = embedding.vector(for: word) else { return [] }
        
        return vectors
    }
    
    private func findDistanceBetween(word1: String, word2: String) -> String {
        guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { return "NA" }
        
        let distance = embedding.distance(between: word1, and: word2)
        
        return distance.formatted()
    }
    
}
