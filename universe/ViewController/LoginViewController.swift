//
//  ViewController.swift
//  universe
//
//  Created by 은구 on 2021/07/25.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {
 
    var userModel = UserModel()
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginKeepingUpButton: UIButton!
    
    //백그라운드 탭했을 때 키보드 내려감
    var keyboardDismissTabGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //키보드에서 return을 누르면 다음 입력창으로 넘어가게 하는 코드
        userIdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        userPasswordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        
        self.keyboardDismissTabGesture.delegate = self
        
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LoginVC - viewWillAppear() called")
        //키보드 올라가는 이벤트를 받는 처리
        //키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("LoginVC - viewWillDisapper() called")
        //키보드 노티 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
            simpleAlert(title: "", message: "e-mail을 입력해주세요.")
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
        
        // 화면전환
        guard let homeVC = self.storyboard?.instantiateViewController(identifier: "TabBarController") else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        print("LoginVC - keyboardWillShowHandle() called")
        //키보드 사이즈 가져오기
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            print("keyboardSize.height : \(keyboardSize.height)")
//            print("signInButton.frame.origin.y : \(signInButton.superview?.frame.origin.y)")
            
            if(keyboardSize.height < (signInButton.superview?.frame.origin.y)!) {
                let distance = keyboardSize.height - (signInButton.superview?.frame.origin.y)!
                
                self.view.frame.origin.y = distance //- signInButton.frame.height
                
            }
        }
    }
    
    @objc func keyboardWillHideHandle() {
        print("LoginVC - keyboardWillHideHandle() called")
        self.view.frame.origin.y = 0
    }
    
    //MARK: - UIGestureRecognizerDelegate
    //화면에서 다른 곳 터치하면 키보드 내려가게
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if(touch.view?.isDescendant(of: userIdTextField) == true) {
            return false
        } else if(touch.view?.isDescendant(of: userPasswordTextField) == true) {
            return false
        } else if(touch.view?.isDescendant(of: loginButton) == true) {
            return false
        } else if(touch.view?.isDescendant(of: loginKeepingUpButton) == true) {
            return false
        } else if(touch.view?.isDescendant(of: signInButton) == true) {
            return false
        } else {
            view.endEditing(true)
            return true
        }
        
    }
    
    /*
    func loginMethod(id: String, password: String) {
        var request = URLRequest(url: URL(string: "http://ec2-13-124-191-131.ap-northeast-2.compute.amazonaws.com:8080/")!)
        request.httpMethod = "POST"
        let params = ["id" : id, "password" : password] as Dictionary
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in }
    }
 */
    
}

/*
final class UserModel {
    struct User {
        var email: String
        var password: String
    }
    
    var users: [User] = [
        User(email: "eungu0920@inu.ac.kr", password: "12345678")
    ]
    
    
}
*/

struct LoginInfo {
    let id: String
    let password: String
}

