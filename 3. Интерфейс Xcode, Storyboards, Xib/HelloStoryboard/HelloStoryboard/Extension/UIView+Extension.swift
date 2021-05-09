//
//  UIView+Extension.swift
//  HelloStoryboard
//
//  Created by Evgenii Semenov on 09.05.2021.
//

import UIKit

extension UIView {
    
    func getViewFromXib() -> UIView? {
        let className = String(describing: Self.self)
        let anyNib = Bundle.main.loadNibNamed(
            className,
            owner: self,
            options: nil
        )?.first
        guard let customView = anyNib as? UIView else { return nil }
        return customView
    }
}
