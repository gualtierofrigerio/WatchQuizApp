//
//  CategoriesList.swift
//  WatchQuizApp WatchKit Extension
//
//  Created by Gualtiero Frigerio on 10/07/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct CategoryRow : View {
    var category:Category
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category.title)
                .font(.title)
            Text("\(category.questions.count) questions")
        }
    }
}

struct CategoriesList : View {
    var dataSource:DataSource
    
    var body: some View {
        List(dataSource.categories.identified(by: \.title)) { category in
            NavigationLink(destination:QuestionsList(category: category)) {
                CategoryRow(category:category)
            }
        }.listStyle(.carousel)
        .navigationBarTitle("Categories")
    }
}

#if DEBUG
struct CategoriesList_Previews : PreviewProvider {
    static var previews: some View {
        CategoriesList(dataSource: DataSource())
    }
}
#endif
