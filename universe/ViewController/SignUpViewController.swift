//
//  SignUpViewController.swift
//  universe
//
//  Created by 은구 on 2021/07/26.
//

import UIKit

class SignUpViewController: UIViewController {
    // 각 사용자의 이메일과 패스워드 저장은 어떻게?
    
    /*
     MVVM Design Pattern
     
     Model
     -
     
     
     View
     -
     
     
     ViewModel
     -
     */
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordCheckTextField: UITextField!
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if userIdTextField.isFirstResponder {
            userPasswordTextField.becomeFirstResponder()
        } else if userPasswordTextField.isFirstResponder {
            userPasswordCheckTextField.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordCheckTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }

    //뒤로가기 버튼
    @IBAction func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
