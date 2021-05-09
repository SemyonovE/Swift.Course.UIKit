//
//  CustomView.swift
//  HelloStoryboard
//
//  Created by Evgenii Semenov on 09.05.2021.
//

import UIKit

class CustomView: UIView {

    private let randomColors: [UIColor] = [.red, .green, .blue, .brown, .yellow, .cyan, .magenta, .orange]
    
    private lazy var xibView: UIView = getViewFromXib() ?? UIView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(xibView)
        
        xibView.backgroundColor = .cyan
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        xibView.frame = self.bounds
    }
    
    @IBAction func viewDidTap(_ sender: UITapGestureRecognizer) {
        sender.view?.backgroundColor = randomColors.randomElement()
    }
}
