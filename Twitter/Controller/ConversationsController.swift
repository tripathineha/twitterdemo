//
//  ConversationsController.swift
//  Twitter
//
//  Created by Neha Tripathi on 04/10/21.
//

import UIKit

class ConversationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }

}

// MARK: - Helper Functions
extension ConversationsController {
    
    func configureUI() {
        navigationItem.title = "Conversations"
    }
    
}
