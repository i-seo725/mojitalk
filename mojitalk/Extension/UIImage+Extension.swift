//
//  UIImage+Extension.swift
//  mojitalk
//
//  Created by 이은서 on 2/27/24.
//

import UIKit

extension UIImage {
    static func randomPhoto() -> UIImage {
        let list: [UIImage] = [.noPhotoAProfile, .noPhotoBProfile, .noPhotoCProfile]
        return list.randomElement()!
    }
}
