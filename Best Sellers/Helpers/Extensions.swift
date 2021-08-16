//
//  Extensions.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 13/08/21.
//

import Foundation
import UIKit

extension String {
    func loadImage() -> UIImage {
        do {
            // convert string to URL.
            guard let url = URL(string: self) else {
                // Return an empty image if the URL is invalid.
                return UIImage()
            }
            // Convert URL to Data
            let data:Data = try Data(contentsOf: url)
            
            // Create UIImage() from Data and optional value if the Image in the URL doesn't exist.
            return UIImage(data: data) ?? UIImage()
            //
        } catch {
            // Catch any errors that might occur.
            print("An error has occured at the time of converting the URL to an Image.")
        }
        return UIImage()
    }
}

// Extensions
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
