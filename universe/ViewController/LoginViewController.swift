//
//  ViewController.swift
//  universe
//
//  Created by 은구 on 2021/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    /*
     MVVM Design Pattern
     
     Model
     -
     
     
     View
     -
     
    
     ViewModel
     -
     */
    var userModel = UserModel()
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                return true
            }
        }
        simpleAlert(title: "로그인 실패", message: "E-mail과 패스워드가 맞지 않습니다.")
        return false
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if userIdTextField.isFirstResponder {
            userPasswordTextField.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //키보드에서 return을 누르면 다음 입력창으로 넘어가게 하는 코드
        userIdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }
    
    func simpleAlert(title: String, message msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
//        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
//        alert.addAction(cancleAction)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = userIdTextField.text, !email.isEmpty else {
            simpleAlert(title: "", message: "E-mail을 입력해주세요.")
            return
            
        }
        guard let password = userPasswordTextField.text, !password.isEmpty else {
            simpleAlert(title: "", message: "비밀번호를 입력해주세요.")
            return
        }
        
        let loginSuccess: Bool = loginCheck(id: email, pwd: password)
        if loginSuccess {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
        
        
    }
    
}

final class UserModel {
    struct User {
        var email: String
        var password: String
    }
    
    var users: [User] = [
        User(email: "eungu0920@inu.ac.kr", password: "12345678")
    ]
    
    
}
