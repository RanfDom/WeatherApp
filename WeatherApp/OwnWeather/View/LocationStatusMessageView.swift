//
//  LocationStatusMessageView.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

protocol LocationStatusMessageViewDelegate: AnyObject {
    func userDidSelectButton(locationStatusView: LocationStatusMessageView, button: UIButton)
}

final class LocationStatusMessageView: UIView {
    
    weak var delegate: LocationStatusMessageViewDelegate?
    
    private let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    private let actionButton: UIButton = {
        let actionButton = UIButton(type: .custom)
        actionButton.backgroundColor = .lightGray
        actionButton.layer.cornerRadius = 5.0
        actionButton.layer.borderWidth = 0.5
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        return actionButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        messageLabel.text = "Localization is not allowed, please change this configuration in order to see the weather on your actual location"
        self.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40.0),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40.0)
        ])
        
        actionButton.setTitle("App Settings", for: .normal)
        self.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 90.0),
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant:20.0),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -90.0),
        ])
    }
    
    @objc
    private func actionButtonTapped(_ sender: UIButton) {
        self.delegate?.userDidSelectButton(locationStatusView: self, button: sender)
    }
}
