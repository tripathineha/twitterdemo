//
//  TweetCell.swift
//  Twitter
//
//  Created by Neha Tripathi on 12/11/21.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet {configure()}
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48/2
        imageView.backgroundColor = .twitterBlue
        return imageView
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor( left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,  paddingBottom: 1, height: 1)
        
        configureActionButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Selectors
extension TweetCell {
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleLikeTapped() {
        
    }
    
    @objc func handleShareTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }
}


// MARK: - Helpers
extension TweetCell {
    func createActionButton(image: UIImage?, handler: Selector ) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.setDimensions(width: 20, height: 20)
        button.tintColor = .darkGray
        button.addTarget(self, action: handler, for: .touchUpInside)
        return button
    }
    
    func configureActionButtons() {
        
        let commentButton = createActionButton(image: UIImage(named: "comment"), handler: #selector(handleCommentTapped))
        let likeButton = createActionButton(image: UIImage(named: "like"), handler: #selector(handleLikeTapped))
        let shareButton = createActionButton(image: UIImage(named: "share"), handler: #selector(handleCommentTapped))
        let retweetButton = createActionButton(image: UIImage(named: "retweet"), handler: #selector(handleCommentTapped))
        
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton,
                                                        likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        actionStack.centerX(inView: self)
    }
    
    func configure() {
        
        guard let tweet = self.tweet else {
            return
        }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
        
    }
}
