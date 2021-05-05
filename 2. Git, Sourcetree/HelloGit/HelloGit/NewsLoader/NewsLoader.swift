//
//  NewsLoader.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 28.03.2021.
//

import Foundation

enum NewsLoader {
    
    static private let news: [NewsModel] = [
        NewsModel(title: "Внимание",
                  text: "Сегодня гололёд! Будьте осторожны!!!",
                  date: "28.03.2021",
                  author: "Андрей Фролов"),
        NewsModel(title: "Британские учёные",
                  text: "В африке обнаружен новый вид белок!",
                  date: "27.03.2021",
                  author: "Кирилл Тунгас"),
        NewsModel(title: "И земля содрогнулась",
                  text: "В городе Энске произошло землетрясение 8 баллов.",
                  date: "20.03.2021",
                  author: "Алексей Иванов")
    ]
    
    static func load() -> [NewsModel] {
        return news
    }
}
