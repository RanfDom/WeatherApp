//
//  ImageViewExtension.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFrom(_ url: URL) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        self.image =  UIImage(data: data)
    }
}
