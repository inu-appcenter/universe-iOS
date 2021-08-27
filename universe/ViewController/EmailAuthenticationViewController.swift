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
        
    }
}
