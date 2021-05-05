//
//  Label.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 27.03.2021.
//

import Foundation

class Label {
    
    private(set) var title: String
    private(set) var textColor: String
    
    init(title: String, textColor: String = "black") {
        self.title = title
        self.textColor = textColor
    }
    
    func setTitle(_ text: String) {
        title = text
    }
    
    func setTextColor(_ color: String) {
        textColor = color
    }
}
