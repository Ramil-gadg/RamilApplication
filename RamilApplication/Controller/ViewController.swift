//
//  ViewController.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 28.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "collectionVC") as? CollectionViewController {
            if textField.text?.trimmingCharacters(in: .whitespaces) != "" {
                vc.textFromTextField = textField.text?.trimmingCharacters(in: .whitespaces)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                showAlert(title: "Введите тему изображений", message: "")
            }
            textField.text = ""
        }
    }
    
}


extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - Alert
extension ViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}



