//
//  UIImage resize.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 19/02/23.
//

import UIKit

extension UIImage {
    func resizeTheImage(newHeight: CGFloat) -> UIImage {
        let scale = newHeight * size.height
        let newWidth = scale * size.width
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer().image { image in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
