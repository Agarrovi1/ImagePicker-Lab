//
//  UserDefaults.swift
//  ImagePicker-Lab
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultWrapper {
    
    private init () {}
    
    static let manager = UserDefaultWrapper()
    
    private let profilePicKey = "profilePic"
    
    func setPic(image: UIImage) {
        if let imageData = image.pngData() {
        UserDefaults.standard.set(imageData, forKey: profilePicKey)
        }
    }
    func getPic() -> UIImage? {
        if let picData = UserDefaults.standard.value(forKey: profilePicKey) as? Data, let image = UIImage(data: picData) {
            return image
        }
        return nil
    }

}
