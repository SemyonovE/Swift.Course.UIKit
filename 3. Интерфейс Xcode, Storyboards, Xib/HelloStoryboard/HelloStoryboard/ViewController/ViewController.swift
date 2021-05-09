//
//  ViewController.swift
//  HelloStoryboard
//
//  Created by Evgenii Semenov on 09.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let showOrangeScreenSegueID = "showOrangeScreen"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    }
    
    @IBAction func orangeViewDidTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: showOrangeScreenSegueID, sender: self)
    }
    
    @IBAction func unwindToRoot(_ unwindSegue: UIStoryboardSegue) {}
}
