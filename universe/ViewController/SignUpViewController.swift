//
//  SignUpViewController.swift
//  universe
//
//  Created by 은구 on 2021/07/26.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordCheckTextField: UITextField!
    
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordCheckTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if userIdTextField.isFirstResponder {
            userPasswordTextField.becomeFirstResponder()
        } else if userPasswordTextField.isFirstResponder {
            userPasswordCheckTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let email = userIdTextField.text, !email.isEmpty else {
            simpleAlert(title: "", message: "e-mail을 입력해주세요.")
            return
        }
        guard let password = userPasswordTextField.text, !password.isEmpty else {
            simpleAlert(title: "", message: "비밀번호를 입력해주세요.")
            return
        }
        guard let passwordCheck = userPasswordCheckTextField.text, !passwordCheck.isEmpty else {
            simpleAlert(title: "", message: "비밀번호확인을 입력해주세요.")
            return
        }
        //이메일 형식검사 만들기
        if password.count < 6 {
            simpleAlert(title: "", message: "비밀번호를 6자리 이상 입력해주세요.")
        }
        if password != passwordCheck {
            simpleAlert(title: "", message: "비밀번호를 동일하게 입력해주세요.")
        }
        
        userModel.createUser(email: email, password: password, passwordCheck: passwordCheck)
        
        request("http://ec2-13-124-191-131.ap-northeast-2.compute.amazonaws.com:8080/email", "POST", ["address": email]) { (success, data) in
            print(data)
        }
    }
    
    func simpleAlert(title: String, message msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    //뒤로가기 버튼
    @IBAction func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
