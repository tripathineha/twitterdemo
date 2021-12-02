//
//  LoginController.swift
//  Twitter
//
//  Created by Neha Tripathi on 04/10/21.
//

import UIKit

class LoginController: UIViewController {

     // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TwitterLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        return Utilities().textField(withPlaceholder: "Email")
    }()
    private let passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = Utilities().systemButton(withTitle: "Log In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
     
     // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         configureUI()
     }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        AuthService.shared.loginUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR: error logging : \(error.localizedDescription)")
            }
            
            print("DEBUG: User \(result?.user.email) Logged in successfully!")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let tabController = window.rootViewController as? MainTabController
            else {
                return
            }
            
            tabController.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true)
        }
    }

    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
 }

 // MARK: - Helper Functions
 extension LoginController {
     
     func configureUI() {
         view.backgroundColor = .twitterBlue
         navigationController?.navigationBar.barStyle = .black
         navigationController?.navigationBar.isHidden = true
         
         view.addSubview(logoImageView)
         logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
         logoImageView.setDimensions(width: 150, height: 150)
         
         
         let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
         stack.axis = .vertical
         stack.spacing = 8
         stack.distribution = .fillEqually
         
         view.addSubview(stack)
         stack.anchor(top: logoImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
         
         view.addSubview(dontHaveAccountButton)
         dontHaveAccountButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
     }
     
 }
