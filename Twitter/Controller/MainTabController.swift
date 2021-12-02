//
//  MainTabController.swift
//  Twitter
//
//  Created by Neha Tripathi on 04/10/21.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?.first as? UINavigationController,
                  let feedController = nav.viewControllers.first as? FeedController else {
                return
            }
            feedController.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        //logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - API
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigationController = UINavigationController(rootViewController: LoginController())
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            fetchUser()
            configureUI()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    // MARK: - Selectors
    @objc func actionButtonTapped() {
        guard let user = user else {
            let alert : UIAlertController = UIAlertController(title: "Error", message: "User does not exist!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let navController = UINavigationController(rootViewController: UploadTweetController(user: user))
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }

}

// MARK: - Helper Functions
extension MainTabController {
    
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavigationController = templateNavigationController(image: UIImage(named: "home_unselected") , rootViewController: feed)
        let explore = ExploreController()
        let exploreNavigationController = templateNavigationController(image: UIImage(named: "search_unselected") , rootViewController: explore)
        let conversations = ConversationsController()
        let conversationsNavigationController = templateNavigationController(image: UIImage(named: "like_unselected") , rootViewController: conversations)
        let notifications = NotificationsController()
        let notificationsNavigationController = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1") , rootViewController: notifications)
        
        viewControllers = [feedNavigationController, exploreNavigationController, notificationsNavigationController, conversationsNavigationController]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.barTintColor = .white
        rootViewController.view.backgroundColor = .white
        return navigationController
    }
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2;
    }
    
    
}
