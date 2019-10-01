//
//  ProfileViewController.swift
//  ImagePicker-Lab
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var mode: Mode = .notEditing
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileNameTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        hideOrShowLabels()
    }
    
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
        if let profilePic = UserDefaultWrapper.manager.getPic(), let profileName = UserDefaultWrapper.manager.getName() {
            profileImageView.image = profilePic
            profileLabel.text =  profileName
        } else {
            return
        }
        
    }
    private func hideOrShowLabels() {
        switch mode {
        case .editing:
            if let text = profileNameTextField.text {
                profileLabel.text = text
                profileLabel.textColor = .white
                UserDefaultWrapper.manager.set(name: text)
            }
            
            profileNameTextField.isHidden = true
            profileLabel.isHidden = false
            mode = .notEditing
            editButton.setTitle("Edit", for: .normal)
        case .notEditing:
            profileNameTextField.isHidden = false
            profileLabel.isHidden = true
            mode = .editing
            editButton.setTitle("Done", for: .normal)
        }
    }
    private func makeGradientBackground() {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.cyan.cgColor,UIColor.purple.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(layer, at: 0)
    }
    private func makeBorderForName() {
        profileLabel.layer.borderColor = UIColor.white.cgColor
        profileLabel.layer.borderWidth = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
        profileNameTextField.isHidden = true
        profileNameTextField.delegate = self
        makeGradientBackground()
        makeBorderForName()
    }
    
}

//MARK: - Extensions
extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        profileImageView.image = image
        UserDefaultWrapper.manager.setPic(image: image)
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            profileLabel.text = text
        }
        return true
    }
}
