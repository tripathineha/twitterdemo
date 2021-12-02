//
//  NotificationsController.swift
//  Twitter
//
//  Created by Neha Tripathi on 04/10/21.
//

import UIKit

class NotificationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }

}


// MARK: - Helper Functions
extension NotificationsController {
    
    func configureUI() {
        navigationItem.title = "Notifications"
    }
    
}
