//
//  NLPService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import NaturalLanguage

class NLPService {
    private let tagger = NLTagger(tagSchemes: [.lexicalClass, .sentimentScore])
    
//    func findAdjAndVerb(in paragraph: String) -> [String] {
//        return findWords(by: [.adjective, .verb], in: paragraph)
//    }
    
    func generateSummary(for paragraph: String, numberOfKeywords: Int = 3) -> [String] {
//        let allText = strings.joined(separator: " ")
        let keywordsFrequency = findWords(by: [.noun, .verb], in: paragraph)
        print("[generateSummary][keywordsFrequency]", keywordsFrequency)
        
        let sortedKeywords = keywordsFrequency.sorted { $0.value > $1.value }
        let topKeywords = Array(sortedKeywords.prefix(numberOfKeywords)).map { $0.key }
        print("[generateSummary][sortedKeywords]", sortedKeywords)
        print("[generateSummary][topKeywords]", topKeywords)
        
        return topKeywords
    }
    
    func generateSummaryUsingTagger(from paragraphs: [String], numberOfSentences: Int = 2) -> String {
        return generateSummaryUsingTokenizer(from: paragraphs, numberOfSentences: numberOfSentences)
    }
    
    func findNegativeSentences(in text: String) -> [String] {
        var negativeSentences = [String]()
        
        let sentenceRange = text.startIndex..<text.endIndex
        tagger.enumerateTags(in: sentenceRange, unit: .sentence, scheme: .sentimentScore) { (tag, _) -> Bool in
            print("[findNegativeSentences][tag]", tag)
            if let tag = tag, let sentimentScore = Double(tag.rawValue), sentimentScore < 0 {
                negativeSentences.append(String(text[sentenceRange]))
            }
            return true
        }

        return negativeSentences
    }

    private func findWords(by tags: [NLTag], in text: String) -> [String: Int] {
        var words = [String: Int]()
        
        tagger.string = text
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: .omitPunctuation) { tag, tokenRange in
            if let tag = tag, tags.contains(tag) {
                let keyword = String(text[tokenRange])
                words[keyword, default: 0] += 1
            }
            return true
        }

        return words
    }
    
    private func findWordFrequency(by tags: [NLTag], in text: String) -> [String: Int] {
        var wordFrequency = [String: Int]()
        
        tagger.string = text
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag, tags.contains(tag) {
                let keyword = String(text[tokenRange])
                wordFrequency[keyword, default: 0] += 1
            }
            return true
        }
        
        return wordFrequency
    }
    
    private func generateSummaryUsingTokenizer(from paragraphs: [String], numberOfSentences: Int) -> String {
        var summaries = ""

        let tokenizer = NLTokenizer(unit: .sentence)
        for paragraph in paragraphs {
            tokenizer.string = paragraph
            var sentences = [String]()
            tokenizer.enumerateTokens(in: paragraph.startIndex..<paragraph.endIndex) { tokenRange, _ in
                sentences.append(String(paragraph[tokenRange]))
                return true
            }

            summaries += sentences.prefix(numberOfSentences).joined(separator: " ") + "\n"
        }

        return summaries
    }
}
