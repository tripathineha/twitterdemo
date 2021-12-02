//
//  ExploreControllerViewController.swift
//  Twitter
//
//  Created by Neha Tripathi on 04/10/21.
//

import UIKit

class ExploreController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
}


// MARK: - Helper Functions
extension ExploreController {
    
    func configureUI() {
        navigationItem.title = "Explore"
    }
    
}
