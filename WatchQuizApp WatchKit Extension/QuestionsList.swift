//
//  QuestionsList.swift
//  WatchQuizApp WatchKit Extension
//
//  Created by Gualtiero Frigerio on 10/07/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

enum AnswerType {
    case correct
    case wrong
    case unanswered
}

struct QuestionRow : View {
    var question:Question
    @State var showAnswers = false
    @State var correct:AnswerType = .unanswered
    
    var answersSheet:ActionSheet {
        var buttons:[ActionSheet.Button] = []
        for answer in question.answers {
            buttons.append(.default(Text(answer), onTrigger: {
                self.checkAnswer(answer: answer)
            }))
        }
        self.showAnswers = false
        return ActionSheet(title: Text(question.question), message: Text("Chose correct answer"), buttons: buttons)
    }
    
    var body : some View {
        VStack {
            Button(action: {
                self.showAnswers.toggle()
            }) {
                HStack {
                    Text(question.question)
                    if correct == .correct {
                        Text("OK")
                            .color(.green)
                    }
                    else if correct == .wrong {
                        Text("WRONG")
                            .color(.red)
                    }
                }
            }
        }.presentation(showAnswers ? answersSheet : nil)
    }
    
    func checkAnswer(answer:String) {
        self.showAnswers = false
        self.correct = question.correctAnswer == answer ? .correct : .wrong
    }
}

struct QuestionsList : View {
    
    var category:Category
    
    var body: some View {
        List(category.questions.identified(by: \.id)) { question in
            QuestionRow(question: question)
        }.navigationBarTitle(category.title)
    }
}

#if DEBUG
struct QuestionsList_Previews : PreviewProvider {
    static var previews: some View {
        QuestionsList(category: DataSource().categories[0])
    }
}
#endif
