//
//  SpinnerView.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

/*
    I've isolated this spinner for better control, but
 */
final class SpinnerView: UIView {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        self.isHidden = false
        spinner.startAnimating()
    }
    
    func stop() {
        self.isHidden = true
        spinner.stopAnimating()
    }
}
