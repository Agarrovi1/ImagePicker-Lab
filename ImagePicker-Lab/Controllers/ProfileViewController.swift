//
//  ProfileViewController.swift
//  ImagePicker-Lab
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        openImagePicker()
    }
    private func openImagePicker() {
        DispatchQueue.main.async {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    private func setDefaults() {
        if let profilePic = UserDefaultWrapper.manager.getPic() {
            profileImageView.image = profilePic
        } else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        profileImageView.image = image
        UserDefaultWrapper.manager.setPic(image: image)
        dismiss(animated: true, completion: nil)
    }
}
