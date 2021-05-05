//
//  Button.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 27.03.2021.
//

import Foundation

class Button {
    
    private(set) var title: String
    private(set) var backgroundColor: String
    private var closure: (() -> Void)?
    
    init(title: String, backgroundColor: String = "clear") {
        self.title = title
        self.backgroundColor = backgroundColor
    }
    
    func setTitle(_ text: String) {
        title = text
    }
    
    func setBackgroundColor(_ color: String) {
        backgroundColor = color
    }
    
    func addAction(_ closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    func touch() {
        closure?()
    }
}
