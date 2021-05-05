//
//  OnboardingScreen.swift
//  HelloGit
//
//  Created by Evgenii Semenov on 28.03.2021.
//

import Foundation

class OnboardingScreen: Screen {
    
    private let titleLabel = Label(title: "Welcome my app")
    private let subtitleLabel = Label(title: "This app will help you to learn git",
                                      textColor: "light-gray")
    private let launchButton = Button(title: "Launch",
                                      backgroundColor: "green")
    
    private var onLaunchButton: (Button) -> Void
    var mainScreen: Screen?
    
    init(title: String, onLaunchButton: @escaping (Button) -> Void) {
        self.onLaunchButton = onLaunchButton
        
        super.init(title: title)
    }
    
    override func didLoad() {
        super.didLoad()
        
        launchButton.addAction {
            [weak self] in
            
            self?.mainScreen = Main(title: "Main")
        }
    }
    
    override func didShow() {
        super.didShow()
        
        onLaunchButton(launchButton)
    }
}
