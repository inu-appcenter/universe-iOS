//
//  EmailAuthenticationViewController.swift
//  universe
//
//  Created by 은구 on 2021/07/26.
//

import UIKit

class EmailAuthenticationViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var authenticationNumberTextField: UITextField!
    
    var timer = Timer()
    var seconds = 240
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    func startTimer() {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(EmailAuthenticationViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    @IBAction func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func timerClass() {
        seconds -= 1
        timerLabel.text = secondsToMinutesAndSeconds(seconds: seconds)
        
        if(seconds == 0) {
            timer.invalidate()
        }
    }
    
    func secondsToMinutesAndSeconds(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        
        return "\(minuteStamp):\(secondStamp)"
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        let signUpData: [String: Any] = [
            "address" : userData.email,
            "authKey" : authenticationNumberTextField.text
        ] as Dictionary
        if timerLabel.text == "00:00" {
            simpleAlert(title: "시간초과", message: "다시 인증번호를 받으세요.")
            return
        } else {
            request("http://ec2-13-124-191-131.ap-northeast-2.compute.amazonaws.com:8080/email/auth", "POST", signUpData){ (success, data) in
                
            }
        }
        
        

        
    }
    
    func simpleAlert(title: String, message msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
