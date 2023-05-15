//
//  ErrorHandling.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

protocol ErrorHandling {
  func show(error: String)
}

/*
    This extension allow us to present an alert message with an error on any UIViewController.
    This extension could evolove into a much more complex error displaying but so far it only displays an informative message
 */
extension ErrorHandling where Self: UIViewController {
  func show(error: String) {
    let alert = UIAlertController(title: "Woops", message: error, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
