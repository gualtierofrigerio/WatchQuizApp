//
//  DataSource.swift
//  WatchQuizApp WatchKit Extension
//
//  Created by Gualtiero Frigerio on 10/07/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Foundation

struct Category {
    var title:String
    var questions:[Question]
    
    mutating func addQuestion(_ question:Question) {
        questions.append(question)
    }
}

struct Question:Codable {
    var id:Int
    var category:String
    var question:String
    var answers:[String]
    var correctAnswer:String
}

class DataSource {
    
    var categories:[Category]
    var questions:[Question]
    
    init() {
        self.categories = []
        self.questions = []
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json") {
            if let questions = getQuestions(fromURL: url) {
                self.questions = questions
                self.categories = createCategories(fromQuestions: questions)
            }
        }
    }
}

extension DataSource {
    private func createCategories(fromQuestions questions:[Question]) -> [Category] {
        var categories:[Category] = []
        for question in questions {
            let category = question.category
            var found = false
            for index in 0..<categories.count {
                if categories[index].title == category {
                    found = true
                    categories[index].addQuestion(question)
                    break
                }
            }
            if !found {
                categories.append(Category(title:category, questions: [question]))
            }
        }
        return categories
    }
    
    private func getQuestions(fromURL url:URL) -> [Question]? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let questions = try? decoder.decode([Question].self, from: data) else {
            return nil
        }
        return questions
    }
}
