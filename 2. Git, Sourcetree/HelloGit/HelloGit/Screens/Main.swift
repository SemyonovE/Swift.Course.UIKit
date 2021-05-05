//
//  Main.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 28.03.2021.
//

import Foundation

class Main: Screen {
    
    private let titleLabel = Label(title: "My super git app")
    
    override func didShow() {
        super.didShow()
        
        print("Loading news")
        NewsLoader.load()
            .sorted { $0.date < $1.date }
            .forEach { print($0) }
    }
}
