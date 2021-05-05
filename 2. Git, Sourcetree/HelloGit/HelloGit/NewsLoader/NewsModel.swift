//
//  NewsModel.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 28.03.2021.
//

import Foundation

struct NewsModel: CustomStringConvertible {
    
    let title: String
    let text: String
    let date: String
    let author: String
    
var description: String {
    """
    --------------------------
    \(title) | \(date)
    --------------------------
    \(text)

    Автор: \(author)


    """
}
}
